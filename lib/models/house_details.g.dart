// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseDetails _$HouseDetailsFromJson(Map<String, dynamic> json) => HouseDetails(
      offeredSince: json['AangebodenSinds'] as String,
      bathrooms: json['AantalBadkamers'] as int?,
      bedrooms: json['AantalSlaapkamers'] as int?,
      floors: json['AantalWoonlagen'] as String,
      acceptance: json['Aanvaarding'] as String,
      address: json['Adres'] as String,
      particularities: json['Bijzonderheden'] as String?,
      constructionYear: json['Bouwjaar'] as String,
      constructionType: json['Bouwvorm'] as String,
      energyLabel: HouseDetails._energyLabelFromJson(
          json['Energielabel'] as Map<String, dynamic>),
      mainImageUrl: json['HoofdFoto'] as String,
      insulation: json['Isolatie'] as String,
      postalCode: json['Postcode'] as String,
      city: json['Plaats'] as String,
      space: json['WoonOppervlakte'] as int?,
      fullDescription: json['VolledigeOmschrijving'] as String,
      houseType: json['SoortWoning'] as String,
      price: Price.fromJson(json['Prijs'] as Map<String, dynamic>),
      cv: json['Cv'] as String?,
    );

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      price: json['Koopprijs'] as int,
      priceAbbreviation: json['KoopAbbreviation'] as String,
    );
