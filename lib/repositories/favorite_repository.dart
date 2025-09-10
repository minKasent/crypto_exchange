import 'package:crypto_exchange/services/storage_service.dart';

class FavoriteRepository {
  final StorageService storageService;

  FavoriteRepository(this.storageService);

  /// Stream that emits whenever favorite tokens change
  Stream<List<String>> get favoritesChangeStream =>
      storageService.favoriteChangeStream;

  /// get favorite list
  List<String> getFavoriteTokens() {
    return storageService.getFavoriteTokens();
  }

  /// Toggle favorite tokens
  Future<void> toggleFavoriteToken(String tokenSymbol) async {
    await storageService.toggleFavoriteToken(tokenSymbol);
  }
}
