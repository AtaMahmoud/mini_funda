import 'package:bloc/bloc.dart';

import '../../../data_providers/funda_homes_repository.dart';
import 'house_overview_event.dart';
import 'house_overview_state.dart';

class HouseOverviewBloc extends Bloc<HouseOverviewEvent, HouseOverviewState> {
  HouseOverviewBloc({required FundaHomesRepository fundaHomesRepository})
      : _fundaHomesRepository = fundaHomesRepository,
        super(const HouseOverviewState.initial()) {
    on<HousesByCityRequested>(_onHousesByCityRequested);
    on<DutchCitiesRequested>(_onDutchCitiesRequested);
  }

  Future<void> _onHousesByCityRequested(
    HousesByCityRequested event,
    Emitter<HouseOverviewState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HouseOverviewStatus.loading));
      final houses = await _fundaHomesRepository.getHousesBy(event.city);
      emit(state.copyWith(status: HouseOverviewStatus.loaded, houses: houses));
    } catch (e, stackTrace) {
      emit(state.copyWith(status: HouseOverviewStatus.failure));
      addError(e, stackTrace);
    }
  }

  Future<void> _onDutchCitiesRequested(
    DutchCitiesRequested event,
    Emitter<HouseOverviewState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HouseOverviewStatus.loading));
      final cities = await _fundaHomesRepository.getDutchCities();
      emit(state.copyWith(status: HouseOverviewStatus.loaded, cities: cities));
    } catch (e, stackTrace) {
      emit(state.copyWith(status: HouseOverviewStatus.failure));
      addError(e, stackTrace);
    }
  }

  final FundaHomesRepository _fundaHomesRepository;
}
