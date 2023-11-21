// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

import '../utils/price_formatter.dart';

part 'house_details.g.dart';

@JsonSerializable(createToJson: false)
class HouseDetails extends Equatable {
  const HouseDetails({
    required this.offeredSince,
    required this.bathrooms,
    required this.bedrooms,
    required this.floors,
    required this.acceptance,
    required this.address,
    this.particularities,
    required this.constructionYear,
    required this.constructionType,
    required this.energyLabel,
    required this.mainImageUrl,
    required this.insulation,
    required this.postalCode,
    required this.city,
    required this.space,
    required this.fullDescription,
    required this.houseType,
    required this.price,
    required this.cv,
  });

  @JsonKey(name: 'AangebodenSinds')
  final String offeredSince;
  @JsonKey(name: 'AantalBadkamers')
  final int? bathrooms;
  @JsonKey(name: 'AantalSlaapkamers')
  final int? bedrooms;
  @JsonKey(name: 'AantalWoonlagen')
  final String floors;
  @JsonKey(name: 'Aanvaarding')
  final String acceptance;
  @JsonKey(name: 'Adres')
  final String address;
  @JsonKey(name: 'Bijzonderheden')
  final String? particularities;
  @JsonKey(name: 'Bouwjaar')
  final String constructionYear;
  @JsonKey(name: 'Bouwvorm')
  final String constructionType;
  @JsonKey(name: 'Energielabel', fromJson: _energyLabelFromJson)
  final String energyLabel;
  @JsonKey(name: 'HoofdFoto')
  final String mainImageUrl;
  @JsonKey(name: 'Isolatie')
  final String insulation;
  @JsonKey(name: 'Postcode')
  final String postalCode;
  @JsonKey(name: 'Plaats')
  final String city;
  @JsonKey(name: 'WoonOppervlakte')
  final int? space;
  @JsonKey(name: 'VolledigeOmschrijving')
  final String fullDescription;
  @JsonKey(name: 'SoortWoning')
  final String houseType;
  @JsonKey(name: 'Prijs')
  final Price price;
  @JsonKey(name: 'Cv')
  final String? cv;

  factory HouseDetails.fromJson(Map<String, dynamic> json) =>
      _$HouseDetailsFromJson(json);

  static String _energyLabelFromJson(Map<String, dynamic> json) =>
      json['Label'] as String;

  String get postalCodeWithCity => "$postalCode $city";

  String get formattedDate {
    String timestampString = offeredSince.split('(')[1].split('+')[0];
    int timestamp = int.parse(timestampString);

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day);

    return DateFormat("MMMM d, y").format(date);
  }

  factory HouseDetails.testInstance() => const HouseDetails(
        offeredSince: "offeredSince",
        bathrooms: 1,
        bedrooms: 1,
        floors: "floors",
        acceptance: "acceptance",
        address: "address",
        constructionYear: "1997",
        constructionType: "constructionType",
        energyLabel: "A",
        mainImageUrl: "mainImageUrl",
        insulation: "insulation",
        postalCode: "postalCode",
        city: "city",
        space: 100,
        fullDescription: "fullDescription",
        houseType: "houseType",
        price: Price(price: 350000, priceAbbreviation: "K.K"),
        cv: "cv",
      );

  @override
  List<Object?> get props => [
        address,
        city,
        postalCode,
        price,
        bathrooms,
        bedrooms,
        constructionYear,
        constructionType
      ];
}

@JsonSerializable(createToJson: false)
class Price extends Equatable {
  const Price({
    required this.price,
    required this.priceAbbreviation,
  });

  @JsonKey(name: 'Koopprijs')
  final int price;
  @JsonKey(name: 'KoopAbbreviation')
  final String priceAbbreviation;

  String get formattedPrice => "${priceFormatter(price)} $priceAbbreviation";

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  @override
  List<Object?> get props => [price, priceAbbreviation];
}
