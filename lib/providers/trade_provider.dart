import 'package:crypto_exchange/core/constants/app_data.dart';
import 'package:crypto_exchange/models/order_book_model.dart';
import 'package:crypto_exchange/repositories/orderbook_repository.dart';
import 'package:flutter/material.dart';

class TradeProvider with ChangeNotifier {
  final OrderbookRepository orderbookRepository;

  TradeProvider(this.orderbookRepository) {
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

  void init() {
    try {
      connectToOrderBookStream(currentSymbol);
    } catch (e) {
      debugPrint('Failed to init TradeProvider: $e');
    }
  }

  void connectToOrderBookStream(String symbol) {
    _bids = [];
    _asks = [];
    currentSymbol = symbol.toLowerCase();

    _setLoading(true);
    _setError(null);

    try {
      orderbookRepository.connectToOrderBook(symbol);

      orderbookRepository.orderBookStream.listen(
        (orderBookData) {
          _bids = orderBookData.bids.take(10).toList();
          _asks = orderBookData.asks.take(10).toList();
          notifyListeners();
          debugPrint('OrderBook data received for symbol: $symbol');
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
    } finally {
      _setLoading(false);
    }
  }

  void toggleBuySell(bool isBuy) {
    _isBuy = isBuy;
    notifyListeners();
  }

  void setSliderValue(double value) {
    _sliderValue = value;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    if (error != null) {
      _setLoading(false);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    orderbookRepository.dispose();
    super.dispose();
  }
}
