import 'dart:async';

import 'package:crypto_exchange/core/constants/app_data.dart';
import 'package:crypto_exchange/models/order_book_model.dart';
import 'package:crypto_exchange/repositories/favorite_repository.dart';
import 'package:crypto_exchange/repositories/orderbook_repository.dart';
import 'package:flutter/material.dart';

class TradeProvider with ChangeNotifier {
  final OrderbookRepository orderbookRepository;
  StreamSubscription<OrderBookModel>? _orderBookSubscription;
  final FavoriteRepository favoriteRepository;

  TradeProvider(this.orderbookRepository, this.favoriteRepository) {
    init();
  }

  List<OrderBookEntry> _bids = [];
  List<OrderBookEntry> get bids => _bids;

  List<OrderBookEntry> _asks = [];
  List<OrderBookEntry> get asks => _asks;

  String currentSymbol = AppData.coins.first;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  bool _isBuy = true;
  bool get isBuy => _isBuy;

  double _sliderValue = 0;
  double get sliderValue => _sliderValue;

  bool get isFavorite =>
      favoriteRepository.getFavoriteTokens().contains(currentSymbol);

  void init() {
    try {
      connectToOrderBookStream(currentSymbol);
    } catch (e) {
      debugPrint('Failed to init TradeProvider: $e');
    }
  }

  void connectToOrderBookStream(String symbol) {
    _orderBookSubscription?.cancel();
    _bids.clear();
    _asks.clear();
    currentSymbol = symbol.toLowerCase();

    _setLoading(true);
    _setError(null);

    try {
      orderbookRepository.connectToOrderBook(symbol);

      _orderBookSubscription = orderbookRepository.orderBookStream.listen(
        (orderBookData) {
          _bids = orderBookData.bids.take(15).toList();
          _asks = orderBookData.asks.take(15).toList();
          _setLoading(false);
          notifyListeners();
        },
        onError: (error) {
          _setError(error.toString());
          debugPrint('OrderBook stream error: $error');
        },
        onDone: () {
          debugPrint('OrderBook stream closed for symbol: $symbol');
        },
      );
    } catch (e) {
      _setError('Failed to connect to order book: $e');
      debugPrint('Failed to connect to order book: $e');
    }
  }

  void toggleBuySell(bool isBuy) {
    if (_isBuy != isBuy) {
      _isBuy = isBuy;
      notifyListeners();
    }
  }

  void setSliderValue(double value) {
    if (_sliderValue != value) {
      _sliderValue = value;
      notifyListeners();
    }
  }

  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  void _setError(String? error) {
    if (_error != error) {
      _error = error;
      if (error != null) {
        _setLoading(false);
      }
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _orderBookSubscription?.cancel();
    orderbookRepository.dispose();
    super.dispose();
  }
}
