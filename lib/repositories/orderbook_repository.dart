import 'package:crypto_exchange/models/order_book_model.dart';
import 'package:crypto_exchange/services/binance_websocket_service.dart';

class OrderbookRepository {
  final BinanceWebsocketService binanceWebsocketService;

  OrderbookRepository(this.binanceWebsocketService);

  Stream<OrderBookModel> get orderBookStream =>
      binanceWebsocketService.orderBookStream;

  void connectToOrderBook(String symbol) {
    binanceWebsocketService.connectToOrderBook(symbol: symbol);
  }

  void dispose() {
    binanceWebsocketService.dispose();
  }
}
