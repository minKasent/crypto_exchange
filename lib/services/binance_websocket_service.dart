// lib/services/binance_websocket_service.dart
import 'dart:async';
import 'dart:convert';

import 'package:crypto_exchange/models/coin.dart';
import 'package:crypto_exchange/models/order_book_model.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceWebsocketService {
  BinanceWebsocketService();

  //  Ticker Stream
  static const String _baseTickerUrl =
      'wss://stream.binance.com:9443/stream?streams=';
  WebSocketChannel? _tickerChannel;
  final StreamController<Map<String, Coin>> _coinStreamController =
  StreamController<Map<String, Coin>>.broadcast();
  Stream<Map<String, Coin>> get coinStream => _coinStreamController.stream;
  final Map<String, Coin> _coinData = {};
  Map<String, Coin> get currentCoins => _coinData;

  // OrderBook Stream
  static const String _baseOrderBookUrl = 'wss://stream.binance.com:9443/ws/';
  WebSocketChannel? _orderBookChannel;
  final StreamController<OrderBook> _orderBookStreamController =
  StreamController<OrderBook>.broadcast();
  Stream<OrderBook> get orderBookStream => _orderBookStreamController.stream;

  Future<void> connectToTickers({required List<String> coins}) async {
    final streams = coins.map((coin) => '${coin.toLowerCase()}@ticker').join('/');
    final url = _baseTickerUrl + streams;
    _tickerChannel = WebSocketChannel.connect(Uri.parse(url));

    if (_tickerChannel == null) return;
    _tickerChannel!.stream.listen(
          (message) {
        final data = jsonDecode(message);
        if (data['data'] != null) {
          final coin = Coin.fromJson(data['data']);
          _coinData[coin.symbol] = coin;
          _coinStreamController.add(_coinData);
        }
      },
      onError: (error) async {
        debugPrint("Error In connecting to ticker websocket: $error");
      },
      onDone: () {
        debugPrint("Connection to ticker websocket closed");
      },
    );
  }

  void connectToOrderBook({required String symbol}) {
    final url = '$_baseOrderBookUrl${symbol.toLowerCase()}@depth5@100ms';

    _orderBookChannel = WebSocketChannel.connect(Uri.parse(url));

    _orderBookChannel!.stream.listen(
          (message) {
        final data = jsonDecode(message);
        if (data != null) {
          final orderBook = OrderBook.fromJson(data);
          _orderBookStreamController.add(orderBook);
        }
      },
      onError: (error) {
        debugPrint("Error In connecting to order book websocket: $error");
        _orderBookStreamController.addError(error);
      },
      onDone: () {
        debugPrint("Connection to order book websocket closed");
      },
    );
  }

  void closeOrderBookChannel() {
    _orderBookChannel?.sink.close();
  }

  void dispose() {
    _coinStreamController.close();
    _orderBookStreamController.close();
    _tickerChannel?.sink.close();
    _orderBookChannel?.sink.close();
  }
}