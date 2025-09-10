// class OrderBook {
//   final List<List<dynamic>> bids; // [price, quantity]
//   final List<List<dynamic>> asks; // [price, quantity]

//   OrderBook({required this.bids, required this.asks});

//   factory OrderBook.fromJson(Map<String, dynamic> json) {
//     final bidsList = json['bids'] as List<dynamic>? ?? [];
//     final asksList = json['asks'] as List<dynamic>? ?? [];

//     return OrderBook(
//       bids: List<List<dynamic>>.from(
//           bidsList.map((x) => List<dynamic>.from(x))),
//       asks: List<List<dynamic>>.from(
//           asksList.map((x) => List<dynamic>.from(x))),
//     );
//   }
// }

// "e": "depthUpdate",
// "E": 1755782224014,
// "s": "BTCUSDT",
// "U": 74993112924,
// "u": 74993113112,
// "b": [
//   [
//     "113210.97000000",
//     "6.22759000"
//   ],
// ],
//   "a": [
//   [
//     "113210.97000000",
//     "6.22759000"
//   ],
// ],

import 'package:json_annotation/json_annotation.dart';
part 'order_book_model.g.dart';

/// DTO -> Data transfer object
@JsonSerializable()
class OrderBookModel {
  @JsonKey(name: 's')
  final String symbol;

  @JsonKey(name: 'b')
  final List<List<String>> bidsRaw;

  @JsonKey(name: 'a')
  final List<List<String>> asksRaw;

  OrderBookModel({
    required this.symbol,
    required this.bidsRaw,
    required this.asksRaw,
  });

  factory OrderBookModel.fromJson(Map<String, dynamic> json) =>
      _$OrderBookModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderBookModelToJson(this);

  List<OrderBookEntry> get bids =>
      bidsRaw.map((x) => OrderBookEntry(price: x[0], quantity: x[1])).toList();
  List<OrderBookEntry> get asks =>
      asksRaw.map((x) => OrderBookEntry(price: x[0], quantity: x[1])).toList();
}

class OrderBookEntry {
  final String price;
  final String quantity;

  OrderBookEntry({required this.price, required this.quantity});
}
