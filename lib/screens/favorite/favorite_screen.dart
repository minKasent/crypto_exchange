import 'package:crypto_exchange/components/app_text.dart';
import 'package:crypto_exchange/core/constants/app_icons_path.dart';
import 'package:crypto_exchange/providers/favorite_provider.dart';
import 'package:crypto_exchange/screens/home_screen/widgets/portfolio_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppText(content: "Favorites")),
      body: Consumer<FavoriteProvider>(
        builder: (_, favoriteProvider, __) {
          return Column(
            children: [
              Flexible(
                child: ListView.separated(
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 16),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favoriteProvider.listOfFavoriteCoins.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  itemBuilder: (context, index) {
                    final item = favoriteProvider.listOfFavoriteCoins[index];
                    return Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: ValueKey(index),

                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),
                        dragDismissible: false,

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(onDismissed: () {}),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (_) {
                              favoriteProvider.toggleFavoriteToken(item.symbol);
                            },
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          SlidableAction(
                            onPressed: (_) {},
                            backgroundColor: Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.share,
                            label: 'Share',
                          ),
                        ],
                      ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        dragDismissible: false,
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 2,
                            onPressed: (_) {},
                            backgroundColor: Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.archive,
                            label: 'Archive',
                          ),
                          SlidableAction(
                            onPressed: (_) {},
                            backgroundColor: Color(0xFF0392CF),
                            foregroundColor: Colors.white,
                            icon: Icons.save,
                            label: 'Save',
                          ),
                        ],
                      ),
                      child: PortfolioCard(
                        iconPath: _getCoinIcon(item.symbol),
                        name: item.symbolName,
                        symbol: item.symbol,
                        value: double.parse(item.price).toStringAsFixed(2),
                        change: item.priceChangePercent,
                        isPositive: !item.priceChangePercent.startsWith('-'),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getCoinIcon(String symbol) {
    switch (symbol.toUpperCase()) {
      case 'BTC':
      case 'BTCUSDT':
        return AppIconsPath.iconsBTC;
      case 'ETH':
      case 'ETHUSDT':
        return AppIconsPath.iconsETH;
      case 'SOL':
      case 'SOLUSDT':
        return AppIconsPath.iconsSLA;
      default:
        return AppIconsPath.iconsBTC; // fallback icon
    }
  }
}
