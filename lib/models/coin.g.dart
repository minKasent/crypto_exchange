// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coin _$CoinFromJson(Map<String, dynamic> json) => Coin(
  symbol: json['s'] as String,
  price: json['c'] as String,
  priceChangePercent: json['P'] as String,
  volume: json['v'] as String,
);

Map<String, dynamic> _$CoinToJson(Coin instance) => <String, dynamic>{
  's': instance.symbol,
  'c': instance.price,
  'P': instance.priceChangePercent,
  'v': instance.volume,
};
