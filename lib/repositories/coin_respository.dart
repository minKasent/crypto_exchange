import 'package:crypto_exchange/models/coin.dart';
import 'package:crypto_exchange/services/binance_websocket_service.dart';

class CoinRespository {
  final BinanceWebsocketService _coinWebsocketService;

  CoinRespository(this._coinWebsocketService);

  // Stream of coin data updates
  Stream<Map<String, Coin>> get coinStream => _coinWebsocketService.coinStream;

  // Initilize websocket connection
  Future<void> init({required List<String> coins}) async {
    await _coinWebsocketService.connectToTickers(coins: coins);
  }

  /// Get coins list
  List<Coin> getCoinsList() {
    return _coinWebsocketService.currentCoins.values.toList();
  }

  // Dispose websocket connection
  void dispose() {
    _coinWebsocketService.dispose();
  }
}
