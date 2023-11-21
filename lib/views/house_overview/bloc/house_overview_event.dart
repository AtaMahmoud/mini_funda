import 'package:equatable/equatable.dart';

abstract class HouseOverviewEvent extends Equatable {
  const HouseOverviewEvent();
}

class HousesByCityRequested extends HouseOverviewEvent {
  const HousesByCityRequested(this.city);

  final String city;

  @override
  List<Object?> get props => [city];
}

class DutchCitiesRequested extends HouseOverviewEvent {
  const DutchCitiesRequested();

  @override
  List<Object?> get props => [];
}
