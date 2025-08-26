import 'package:crypto_exchange/models/coin.dart';
import 'package:crypto_exchange/repositories/coin_repository.dart';
import 'package:crypto_exchange/repositories/favorite_repository.dart';
import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  final FavoriteRepository favoriteRepository;
  final CoinRepository coinRepository;

  FavoriteProvider(this.coinRepository, this.favoriteRepository) {
    init();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  List<Coin> _listOfFavoriteCoins = [];
  List<Coin> get listOfFavoriteCoins => _listOfFavoriteCoins;

  List<String> _listOfFavoriteSymbols = [];

  List<Coin> _listAllCoins = [];

  Future<void> init() async {
    try {
      _setLoading(true);

      /// get the favorite coins from repository
      _listOfFavoriteSymbols = favoriteRepository.getFavoriteTokens();
      _listAllCoins = coinRepository.getCoinsList();

      /// Listen to favorite coins changes from FavoriteRepository Stream
      favoriteRepository.favoritesChangeStream.listen((favorites) {
        _listOfFavoriteSymbols = favorites;

        /// Update favorite coin
        _updateFavoriteCoins(_listAllCoins);
      });

      /// Listen to coin updates then update the list coin -> to display
      coinRepository.coinStream.listen((allCoins) {
        /// Update favorite coin
        _updateFavoriteCoins(allCoins.values.toList());
      });
    } catch (e) {
      debugPrint('Failed to init FavoriteProvider: $e');
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _updateFavoriteCoins(List<Coin> allCoins) {
    /// Take only the coins that are in the list of favorite coins
    _listOfFavoriteCoins =
        allCoins
            .where(
              (coin) =>
                  _listOfFavoriteSymbols.contains(coin.symbol.toLowerCase()),
            )
            .toList();
    notifyListeners();
  }

  /// Toggle favorite token
  Future<void> toggleFavoriteToken(String tokenSymbol) async {
    try {
      _setError(null);
      _setLoading(true);

      await favoriteRepository.toggleFavoriteToken(tokenSymbol);
      _listOfFavoriteSymbols = favoriteRepository.getFavoriteTokens();
      _updateFavoriteCoins(_listAllCoins);
    } catch (e) {
      debugPrint('Failed to toggle favorite token: $e');
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    // loading là trạng thái mới
    if (loading != _isLoading) {
      // nếu loading khác với trạng thái hiện tại
      _isLoading = loading; // cập nhật trạng thái loading
      notifyListeners(); // thông báo cho các widget lắng nghe rằng trạng thái đã thay đổi
      // chỉ khi nào loading khác với trạng thái hiện tại thì mới cập nhật
    }
  }

  void _setError(String? error) {
    // error là thông báo lỗi mới
    if (error != _error) {
      // nếu error khác với thông báo lỗi hiện tại
      _error = error; // cập nhật thông báo lỗi
      notifyListeners();
    }
  }
}
