import 'dart:async';
import 'dart:convert';

import 'package:crypto_exchange/models/coin.dart';
import 'package:flutter/widgets.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CoinWebsocketService {
  static final List<String> coins = [
    'btcusdt',
    'ethusdt',
    'bnbusdt',
    'solusdt',
    'adausdt',
    'xrpusdt',
    'dotusdt',
    'maticusdt',
    'dogeusdt',
    'avaxusdt',
    'linkusdt',
    'ltcusdt',
    'atomusdt',
    'nearusdt',
    'filusdt',
    'uniusdt',
    'trxusdt',
    'xlmusdt',
    'apeusdt',
    'egldusdt',
  ];

  // Stream format: {coin}@ticker
  // Example for 4 coins: wss://stream.binance.com:9443/stream?streams=btcusdt@ticker/ethusdt@ticker/bnbusdt@ticker/solusdt@ticker

  static const String _baseUrl =
      'wss://stream.binance.com:9443/stream?streams=';

  // Create streams parameter for all coins
  static final streams = coins.map((coin) => '$coin@ticker').join('/'); // join all streams with '/' separator
  static final url = '$_baseUrl$streams'; // final URL for websocket connection

  WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(url)); // connect to the websocket URL

  final StreamController<Map<String, Coin>> _coinStreamController =
      StreamController<Map<String, Coin>>.broadcast(); // broadcast stream controller to allow multiple listeners

  Stream<Map<String, Coin>> get coinStream => _coinStreamController.stream; // expose the stream to listen for coin updates

  /// Connect to binance websocket and listen for symbol coin updates
  Future<void> connect() async {
    try {
      channel.stream.listen((message) {// lắng nghe dữ liệu từ websocket
          final data = jsonDecode(message); // decode Json

          if (data['data'] != null) {
            final coin = Coin.fromJson(data['data']); // convert to Coin model
            _coinStreamController.sink.add({coin.symbol: coin}); // add to stream controller
            debugPrint("Updated coin data for ${coin.symbol}: $coin}");
          }
        },
        onError: (error) async {
          debugPrint("Error In connecting to websocket coin data: $error");

          /// Attempt to reconnect after a delay
          await Future.delayed(Duration(seconds: 3)); // wait for 3 seconds reconnect
          connect(); // reconnect to websocket
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

  void dispose() { // close the stream controller and websocket channel
    _coinStreamController.close();
  }
}
