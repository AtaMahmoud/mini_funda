// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../models/city.dart';
import '../../../models/house.dart';

enum HouseOverviewStatus {
  initial,
  loading,
  loaded,
  failure,
}

class HouseOverviewState extends Equatable {
  const HouseOverviewState({
    required this.status,
    this.houses = const [],
    this.cities = const [],
  });

  final HouseOverviewStatus status;
  final List<House> houses;
  final List<City> cities;

  const HouseOverviewState.initial()
      : this(status: HouseOverviewStatus.initial);

  HouseOverviewState copyWith({
    HouseOverviewStatus? status,
    List<House>? houses,
    List<City>? cities,
  }) =>
      HouseOverviewState(
        status: status ?? this.status,
        houses: houses ?? this.houses,
        cities: cities ?? this.cities,
      );

  @override
  List<Object?> get props => [status, houses];
}
