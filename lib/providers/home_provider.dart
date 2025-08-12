import 'dart:async';

import 'package:crypto_exchange/core/constants/app_data.dart';
import 'package:crypto_exchange/models/coin.dart';
import 'package:crypto_exchange/repositories/coin_respository.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider(this._coinRespository) {
    init();
  }

  final CoinRespository _coinRespository;

  bool _isLoading = false;
  bool get isLoaded => _isLoading;

  String? _error;
  String? get error => _error;
  List<Coin> _listOfCoins = [];
  List<Coin> get listOfCoins => _listOfCoins;

  // Initilize provider to connect with repository
  Future<void> init() async {
    try {
      _setLoading(true);
      await _coinRespository.init(coins: AppData.coins);

      /// listen to stream data
      _coinRespository.coinStream.listen(
        (message) {
          _listOfCoins = message.values.toList();

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
