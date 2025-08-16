import 'dart:async';

import 'package:crypto_exchange/core/constants/app_data.dart';
import 'package:crypto_exchange/models/coin.dart';
import 'package:crypto_exchange/repositories/coin_respository.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  HomeProvider(this._coinRespository) {
    // init();
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

  void _setLoading(bool loading) {// loading là trạng thái mới
    if (loading != _isLoading) { // nếu loading khác với trạng thái hiện tại
      _isLoading = loading; // cập nhật trạng thái loading
      notifyListeners();// thông báo cho các widget lắng nghe rằng trạng thái đã thay đổi
      // chỉ khi nào loading khác với trạng thái hiện tại thì mới cập nhật
    }
  }

  void _setError(String? error) {// error là thông báo lỗi mới
    if (error != _error) { // nếu error khác với thông báo lỗi hiện tại
      _error = error; // cập nhật thông báo lỗi
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _coinRespository.dispose();
    super.dispose();
  }
}
