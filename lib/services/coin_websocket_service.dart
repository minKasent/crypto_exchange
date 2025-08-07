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
  static final streams = coins.map((coin) => '$coin@ticker').join('/');
  static final url = '$_baseUrl$streams';

  WebSocketChannel channel = WebSocketChannel.connect(Uri.parse(url));

  final StreamController<Map<String, Coin>> _coinStreamController =
      StreamController<Map<String, Coin>>.broadcast();

  Stream<Map<String, Coin>> get coinStream => _coinStreamController.stream;

  /// Connect to binance websocket and listen for symbol coin updates
  Future<void> connect() async {
    try {
      channel.stream.listen(
        (message) {
          final data = jsonDecode(message);

          if (data['data'] != null) {
            final coin = Coin.fromJson(data['data']);
            _coinStreamController.sink.add({coin.symbol: coin});
            debugPrint("Updated coin data for ${coin.symbol}: $coin}");
          }
        },
        onError: (error) async {
          debugPrint("Error In connecting to websocket coin data: $error");

          /// Attempt to reconnect after a delay
          await Future.delayed(Duration(seconds: 3));
          connect();
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
    _coinStreamController.close();
  }
}
