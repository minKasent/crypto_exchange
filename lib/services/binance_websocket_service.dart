import 'dart:async';
import 'dart:convert';
import 'package:crypto_exchange/models/coin.dart';
import 'package:crypto_exchange/models/order_book_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceWebsocketService {
  BinanceWebsocketService();

  static const String _baseTickerUrl = 'wss://stream.binance.com:9443/stream?streams=';
  static const String _baseOrderBookUrl = 'wss://stream.binance.com:9443/ws/';

  WebSocketChannel? _tickerChannel;
  WebSocketChannel? _orderBookChannel;

  final StreamController<Map<String, Coin>> _coinStreamController = StreamController<Map<String, Coin>>.broadcast();
  StreamController<OrderBookModel>? _orderBookStreamController;

  Stream<Map<String, Coin>> get coinStream => _coinStreamController.stream;
  Stream<OrderBookModel> get orderBookStream => _orderBookStreamController?.stream ?? const Stream.empty();

  final Map<String, Coin> _coinData = {};
  Map<String, Coin> get currentCoins => _coinData;

  Future<void> connectToTickers({required List<String> coins}) async {
    try {
      await _tickerChannel?.sink.close();

      final streams = coins.map((coin) => '${coin.toLowerCase()}@ticker').join('/');
      final url = _baseTickerUrl + streams;
      _tickerChannel = WebSocketChannel.connect(Uri.parse(url));

      _tickerChannel!.stream.listen(
            (message) {
          try {
            final data = jsonDecode(message);
            if (data['data'] != null) {
              final coin = Coin.fromJson(data['data']);
              _coinData[coin.symbol] = coin;
              if (!_coinStreamController.isClosed) {
                _coinStreamController.add(Map.from(_coinData));
              }
            }
          } catch (e) {
            debugPrint("Error parsing ticker data: $e");
          }
        },
        onError: (error) => debugPrint("Ticker websocket error: $error"),
        onDone: () => debugPrint("Ticker websocket closed"),
      );
    } catch (e) {
      debugPrint("Error connecting to ticker websocket: $e");
    }
  }

  void connectToOrderBook({required String symbol}) {
    disposeOrderBook();

    try {
      final url = '$_baseOrderBookUrl${symbol.toLowerCase()}@depth';
      _orderBookChannel = WebSocketChannel.connect(Uri.parse(url));
      _orderBookStreamController = StreamController<OrderBookModel>.broadcast();

      _orderBookChannel!.stream.listen(
            (message) {
          try {
            final data = jsonDecode(message);
            final orderBook = OrderBookModel.fromJson(data);
            if (!_orderBookStreamController!.isClosed) {
              _orderBookStreamController!.add(orderBook);
            }
          } catch (e) {
            debugPrint("Error parsing orderbook data: $e");
            if (!_orderBookStreamController!.isClosed) {
              _orderBookStreamController!.addError(e);
            }
          }
        },
        onError: (error) {
          debugPrint("OrderBook websocket error: $error");
          if (!_orderBookStreamController!.isClosed) {
            _orderBookStreamController!.addError(error);
          }
        },
        onDone: () => debugPrint("OrderBook websocket closed"),
      );
    } catch (e) {
      debugPrint("Error connecting to orderbook: $e");
      _orderBookStreamController?.addError(e);
    }
  }

  void disposeOrderBook() {
    _orderBookChannel?.sink.close();
    _orderBookChannel = null;
    _orderBookStreamController?.close();
    _orderBookStreamController = null;
  }

  void dispose() {
    _coinStreamController.close();
    disposeOrderBook();
    _tickerChannel?.sink.close();
  }
}