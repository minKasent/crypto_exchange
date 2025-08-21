import 'dart:async';
import 'package:crypto_exchange/models/order_book_model.dart';
import 'package:crypto_exchange/services/binance_websocket_service.dart';
import 'package:flutter/material.dart';

class TradeProvider with ChangeNotifier {
  final BinanceWebsocketService _websocketService;

  TradeProvider(this._websocketService);

  OrderBook? _orderBook;
  OrderBook? get orderBook => _orderBook;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  bool _isBuy = true;
  bool get isBuy => _isBuy;

  double _sliderValue = 0;
  double get sliderValue => _sliderValue;

  StreamSubscription? _orderBookSubscription;
  Timer? _timeoutTimer;

  final TextEditingController priceController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController totalController = TextEditingController();

  void connectToOrderBookStream(String symbol) {
    _orderBookSubscription?.cancel();
    _timeoutTimer?.cancel();

    _setLoading(true);
    _setError(null);

    _timeoutTimer = Timer(const Duration(seconds: 10), () {
      if (_isLoading) {
        _setError('Connection timeout. Please try again.');
        debugPrint('OrderBook connection timeout for symbol: $symbol');
      }
    });

    try {
      _websocketService.connectToOrderBook(symbol: symbol);

      _orderBookSubscription = _websocketService.orderBookStream.listen(
        (orderBookData) {
          _timeoutTimer?.cancel();
          _orderBook = orderBookData;
          _setLoading(false);
          _setError(null);
          notifyListeners();
          debugPrint('OrderBook data received for symbol: $symbol');
        },
        onError: (error) {
          _timeoutTimer?.cancel();
          _setError(error.toString());
          debugPrint('OrderBook stream error: $error');
        },
        onDone: () {
          _timeoutTimer?.cancel();
          _setLoading(false);
          debugPrint('OrderBook stream closed for symbol: $symbol');
        },
      );
    } catch (e) {
      _timeoutTimer?.cancel();
      _setError('Failed to connect to order book: $e');
      debugPrint('Failed to connect to order book: $e');
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
    _orderBookSubscription?.cancel();
    _timeoutTimer?.cancel();
    _websocketService.closeOrderBookChannel();
    priceController.dispose();
    amountController.dispose();
    totalController.dispose();
    super.dispose();
  }
}