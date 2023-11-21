import 'package:bloc/bloc.dart';

import '../../../data_providers/funda_homes_repository.dart';
import 'house_details_event.dart';
import 'house_details_state.dart';

class HouseDetailsBloc extends Bloc<HouseDetailsEvent, HouseDetailsState> {
  HouseDetailsBloc({
    required FundaHomesRepository fundaHomesRepository,
    required String houseId,
  })  : _fundaHomesRepository = fundaHomesRepository,
        _houseId = houseId,
        super(const HouseDetailsState.initialState()) {
    on<HouseDetailsRequested>(_onHousesDetailsRequested);
  }

  Future<void> _onHousesDetailsRequested(
    HouseDetailsRequested event,
    Emitter<HouseDetailsState> emit,
  ) async {
    try {
      emit(state.copyWith(status: HouseDetailsStatus.loading));
      final houseDetails =
          await _fundaHomesRepository.getHouseDetailsBy(_houseId);
      emit(
        state.copyWith(
            status: HouseDetailsStatus.loaded, houseDetails: houseDetails),
      );
    } catch (e, stackTrace) {
      emit(state.copyWith(status: HouseDetailsStatus.failure));
      addError(e, stackTrace);
    }
  }

  final FundaHomesRepository _fundaHomesRepository;
  final String _houseId;
}
