// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../models/house_details.dart';


enum HouseDetailsStatus {
  initial,
  loading,
  loaded,
  failure,
}

class HouseDetailsState extends Equatable {
  const HouseDetailsState({
    this.houseDetails,
    required this.status,
  });

  final HouseDetails? houseDetails;
  final HouseDetailsStatus status;

  const HouseDetailsState.initialState()
      : this(status: HouseDetailsStatus.initial);

  HouseDetailsState copyWith({
    HouseDetailsStatus? status,
    HouseDetails? houseDetails,
  }) =>
      HouseDetailsState(
        status: status ?? this.status,
        houseDetails: houseDetails ?? this.houseDetails,
      );

  @override
  List<Object?> get props => [houseDetails, status];
}
