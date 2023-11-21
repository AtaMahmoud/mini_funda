import 'package:equatable/equatable.dart';

abstract class HouseDetailsEvent extends Equatable {
  const HouseDetailsEvent();
}

class HouseDetailsRequested extends HouseDetailsEvent {
  const HouseDetailsRequested();

  @override
  List<Object?> get props => [];
}
