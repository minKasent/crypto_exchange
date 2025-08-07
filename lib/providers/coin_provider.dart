import 'dart:async';

import 'package:crypto_exchange/models/coin.dart';
import 'package:crypto_exchange/repositories/coin_respository.dart';
import 'package:flutter/material.dart';

class CoinProvider with ChangeNotifier {
  final CoinRespository _coinRespository = CoinRespository();
  // StreamSubscription<Map<String, Coin>>? _coinStreamSubscription;

  bool _isLoading = false;
  bool get isLoaded => _isLoading;

  String? _error;
  String? get error => _error;

  Map<String, Coin> _coins = {};
  List<Coin> _listOfCoins = [];
  List<Coin> get listOfCoins => _listOfCoins;

  // Initilize provider to connect with repository
  Future<void> init() async {
    try {
      _setLoading(true);
      await _coinRespository.init();

      /// listen to stream data
      _coinRespository.coinStream.listen(
        (message) {
          _coins = message;

          /// Convert from Map<String, Coin> _coins to List<Coin> _listOfCoins from each Coin in map by key
          ///  and later update it element by message
          /// First add all element into the _listOfCoins when it's empty
          /// Later after receive new message from stream but if it message contains the same key
          /// -> replace new one by index else add new ones
          /// update it element by message

          /// Initialize _listOfCoins if it's empty
          if (_listOfCoins.isEmpty) {
            _listOfCoins = _coins.values.toList();
          } else {
            // Update only the existing coins or add new ones
            for (var entry in message.entries) {
              final index = _listOfCoins.indexWhere(
                (coin) => coin.symbol == entry.key,
              );
              if (index != -1) {
                // Update existing coin
                _listOfCoins[index] = entry.value;
              } else {
                // Add new coin if not found
                _listOfCoins.add(entry.value);
              }
            }
          }

          notifyListeners();
          debugPrint('_listOfCoins length: ${_listOfCoins.length}');
        },
        onError: (error) {
          _setError('Failed to connect with repository: $error');
          debugPrint('Failed to connect with repository: $error');
        },
      );
    } catch (e) {
      _setError('Failed to connect with repository: $e');
      debugPrint('Failed to connect with repository: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    if (loading != _isLoading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  void _setError(String? error) {
    if (error != _error) {
      _error = error;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _coinRespository.dispose();
    super.dispose();
  }
}
