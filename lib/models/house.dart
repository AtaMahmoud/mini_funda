import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/price_formatter.dart';

part 'house.g.dart';

@JsonSerializable(createToJson: false)
class House extends Equatable {
  final String id;
  final String address;
  final String postCode;
  final int price;
  final String bedrooms;
  final String coverImageUrl;

  const House({
    required this.id,
    required this.address,
    required this.postCode,
    required this.price,
    required this.bedrooms,
    required this.coverImageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        address,
        postCode,
        price,
        bedrooms,
        coverImageUrl,
      ];

  factory House.fromJson(Map<String, dynamic> json) => _$HouseFromJson(json);

  String get formattedPrice => priceFormatter(price);
}
