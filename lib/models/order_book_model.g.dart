// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderBookModel _$OrderBookModelFromJson(Map<String, dynamic> json) =>
    OrderBookModel(
      symbol: json['s'] as String,
      bidsRaw:
          (json['b'] as List<dynamic>)
              .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
              .toList(),
      asksRaw:
          (json['a'] as List<dynamic>)
              .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
              .toList(),
    );

Map<String, dynamic> _$OrderBookModelToJson(OrderBookModel instance) =>
    <String, dynamic>{
      's': instance.symbol,
      'b': instance.bidsRaw,
      'a': instance.asksRaw,
    };
