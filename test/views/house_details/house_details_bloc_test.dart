import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_funda/data_providers/funda_homes_repository.dart';
import 'package:mini_funda/models/house_details.dart';
import 'package:mini_funda/views/house_details.dart/bloc/house_details_bloc.dart';
import 'package:mini_funda/views/house_details.dart/bloc/house_details_event.dart';
import 'package:mini_funda/views/house_details.dart/bloc/house_details_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../common_test_mocks.dart';

void main() {
  group("HouseDetailsBloc", () {
    const houseId = "House_Id";
    late HouseDetailsBloc houseDetailsBloc;
    late FundaHomesRepository fundaHomesRepository;

    setUp(() {
      fundaHomesRepository = MockFundaHomesRepository();

      houseDetailsBloc = HouseDetailsBloc(
        houseId: houseId,
        fundaHomesRepository: fundaHomesRepository,
      );
    });

    group("on HouseDetailsRequested", () {
      setUp(() {
        when(() => fundaHomesRepository.getHouseDetailsBy(houseId))
            .thenAnswer((_) async => HouseDetails.testInstance());
      });

      blocTest<HouseDetailsBloc, HouseDetailsState>(
        'emits [loading, loaded] '
        'when getHouseDetailsBy succeeds',
        build: () => houseDetailsBloc,
        act: (bloc) => bloc.add(const HouseDetailsRequested()),
        expect: () => <HouseDetailsState>[
          const HouseDetailsState(status: HouseDetailsStatus.loading),
          HouseDetailsState(
            status: HouseDetailsStatus.loaded,
            houseDetails: HouseDetails.testInstance(),
          )
        ],
      );

      blocTest<HouseDetailsBloc, HouseDetailsState>(
        'emits [loading, failure] '
        'when getHouseDetailsBy fails',
        setUp: () => when(() => fundaHomesRepository.getHouseDetailsBy(houseId))
            .thenThrow(Exception()),
        build: () => houseDetailsBloc,
        act: (bloc) => bloc.add(const HouseDetailsRequested()),
        expect: () => <HouseDetailsState>[
          const HouseDetailsState(status: HouseDetailsStatus.loading),
          const HouseDetailsState(status: HouseDetailsStatus.failure),
        ],
      );
    });
  });
}
