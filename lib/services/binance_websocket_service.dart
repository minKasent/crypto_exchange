import 'dart:async';
import 'dart:convert';

import 'package:crypto_exchange/models/coin.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceWebsocketService {
  BinanceWebsocketService();

  /// Tickers
  // Stream format: {coin}@ticker
  // Example for 4 coins: wss://stream.binance.com:9443/stream?streams=btcusdt@ticker/ethusdt@ticker/bnbusdt@ticker/solusdt@ticker

  static const String _baseTickerUrl =
      'wss://stream.binance.com:9443/stream?streams=';

  WebSocketChannel? _tickerChannel;

  /// broadcast stream controller to allow multiple listeners
  final StreamController<Map<String, Coin>> _coinStreamController =
      StreamController<Map<String, Coin>>.broadcast();

  /// expose the stream to listen for coin updates
  Stream<Map<String, Coin>> get coinStream => _coinStreamController.stream;

  /// Map of coin data
  final Map<String, Coin> _coinData = {};

  /// Getter for coin data
  Map<String, Coin> get currentCoins => _coinData;

  /// Connect to binance websocket and listen for symbol coin updates
  Future<void> connectToTickers({required List<String> coins}) async {
    try {
      /// Create stream parameter for all coins
      final streams = coins
          .map((coin) => '${coin.toLowerCase()}@ticker')
          .join('/');

      /// create url
      final url = _baseTickerUrl + streams;

      /// Create websocket channel
      _tickerChannel = WebSocketChannel.connect(Uri.parse(url));

      /// Listen to websocket channel
      if (_tickerChannel == null) return;

      _tickerChannel!.stream.listen(
        (message) {
          // listen to datat from websocket
          final data = jsonDecode(message); // decode string to json

          if (data['data'] != null) {
            final coin = Coin.fromJson(
              data['data'],
            ); // convert json to Coin model
            /// Add new data to stream
            _coinData[coin.symbol] = coin;
            _coinStreamController.add(_coinData);
            debugPrint("Updated coin data for ${coin.symbol}: $coin}");
          }
        },
        onError: (error) async {
          debugPrint("Error In connecting to websocket coin data: $error");

          /// Attempt to reconnect after a delay
          // await Future.delayed(
          //   Duration(seconds: 3),
          // ); // wait for 3 seconds reconnect
          // connectToTickers(); // reconnect to websocket
        },
        onDone: () {
          debugPrint("Connection to websocket closed");
        },
      );
    } catch (e) {
      debugPrint("Failed to connect to websocket: $e");
      throw Exception("Failed to connect to websocket: $e");
    }
  }

  void dispose() {
    // close the stream controller and websocket channel
    _coinStreamController.close();
    if (_tickerChannel != null) {
      _tickerChannel!.sink.close();
    }
  }

  /// Orderbook
}
