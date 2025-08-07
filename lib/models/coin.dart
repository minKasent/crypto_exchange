// {
//   "stream": "btcusdt@ticker",
//   "data": {
//     "e": "24hrTicker",
//     "E": 1754575631020,
//     "s": "BTCUSDT",
//     "p": "2014.01000000",
//     "P": "1.759",
//     "w": "115439.04233238",
//     "x": "114485.99000000",
//     "c": "116500.00000000",
//     "Q": "0.00952000",
//     "b": "116499.99000000",
//     "B": "3.88218000",
//     "a": "116500.00000000",
//     "A": "5.13512000",
//     "o": "114485.99000000",
//     "h": "116828.93000000",
//     "l": "113869.88000000",
//     "v": "12575.51442000",
//     "q": "1451705341.48188450",
//     "O": 1754489230999,
//     "C": 1754575630999,
//     "F": 5136419893,
//     "L": 5138453121,
//     "n": 2033229
//   }
// }

import 'package:json_annotation/json_annotation.dart';

part 'coin.g.dart';

@JsonSerializable()
class Coin {
  @JsonKey(name: 's')
  final String symbol;

  @JsonKey(name: 'c')
  final String price;

  @JsonKey(name: 'P')
  final String priceChangePercent;

  @JsonKey(name: 'v')
  final String volume;

  Coin({
    required this.symbol,
    required this.price,
    required this.priceChangePercent,
    required this.volume,
  });

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);

  Map<String, dynamic> toJson() => _$CoinToJson(this);

  /// symbol is BTCUSDT, ETHUSDT -> write function get symbol name is BTC , ETH
  String get symbolName {
    return symbol.replaceAll('USDT', '');
  }
}
