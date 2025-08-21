class OrderBook {
  final List<List<dynamic>> bids; // [price, quantity]
  final List<List<dynamic>> asks; // [price, quantity]

  OrderBook({required this.bids, required this.asks});

  factory OrderBook.fromJson(Map<String, dynamic> json) {
    final bidsList = json['bids'] as List<dynamic>? ?? [];
    final asksList = json['asks'] as List<dynamic>? ?? [];

    return OrderBook(
      bids: List<List<dynamic>>.from(
          bidsList.map((x) => List<dynamic>.from(x))),
      asks: List<List<dynamic>>.from(
          asksList.map((x) => List<dynamic>.from(x))),
    );
  }
}