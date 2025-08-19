import 'package:crypto_exchange/models/coin.dart';
import 'package:crypto_exchange/services/binance_websocket_service.dart';

class CoinRepository {
  final BinanceWebsocketService _coinWebsocketService;

  CoinRepository(this._coinWebsocketService);

  // Stream of coin data updates
  Stream<Map<String, Coin>> get coinStream => _coinWebsocketService.coinStream;// lấy stream từ BinanceWebsocketService

  // Initilize websocket connection
  Future<void> init({required List<String> coins}) async {// init websocket connection with list of coins
    await _coinWebsocketService.connectToTickers(coins: coins);
  }

  /// Get coins list
  List<Coin> getCoinsList() { // lấy coin hiện tại từ BinanceWebsocketService sau đó chuyển sang list
    return _coinWebsocketService.currentCoins.values.toList();
  }

  // Dispose websocket connection
  void dispose() { // đóng kết nối websocket
    _coinWebsocketService.dispose();
  }
}
