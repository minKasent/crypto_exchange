import 'package:crypto_exchange/models/coin.dart';
import 'package:crypto_exchange/services/coin_websocket_service.dart';

class CoinRespository {
  final CoinWebsocketService _coinWebsocketService = CoinWebsocketService();

  // Stream of coin data updates
  Stream<Map<String, Coin>> get coinStream => _coinWebsocketService.coinStream;

  // Initilize websocket connection
  Future<void> init() async {
    await _coinWebsocketService.connect();
  }

  // Dispose websocket connection
  void dispose() {
    _coinWebsocketService.dispose();
  }
}
