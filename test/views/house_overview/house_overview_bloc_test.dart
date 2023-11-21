import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_funda/data_providers/funda_homes_repository.dart';
import 'package:mini_funda/models/city.dart';
import 'package:mini_funda/models/house.dart';
import 'package:mini_funda/views/house_overview/bloc/house_overview_bloc.dart';
import 'package:mini_funda/views/house_overview/bloc/house_overview_event.dart';
import 'package:mini_funda/views/house_overview/bloc/house_overview_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../common_test_mocks.dart';

void main() {
  group("HouseOverviewBloc", () {
    late HouseOverviewBloc houseOverviewBloc;
    late FundaHomesRepository fundaHomesRepository;

    setUp(() {
      fundaHomesRepository = MockFundaHomesRepository();

      houseOverviewBloc = HouseOverviewBloc(
        fundaHomesRepository: fundaHomesRepository,
      );
    });

    group("on HousesByCityRequested", () {
      const city = "city";

      final fetchedHouses = [
        House.testInstance(testId: "id_1", testAddress: "Address_1"),
        House.testInstance(testId: "id_2", testAddress: "Address_2"),
      ];

      setUp(() {
        when(() => fundaHomesRepository.getHousesBy(city))
            .thenAnswer((_) async => fetchedHouses);
      });

      blocTest<HouseOverviewBloc, HouseOverviewState>(
        'emits [loading, loaded] '
        'when getHousesBy succeeds',
        build: () => houseOverviewBloc,
        act: (bloc) => bloc.add(const HousesByCityRequested(city)),
        expect: () => <HouseOverviewState>[
          const HouseOverviewState(status: HouseOverviewStatus.loading),
          HouseOverviewState(
              status: HouseOverviewStatus.loaded, houses: fetchedHouses),
        ],
      );

      blocTest<HouseOverviewBloc, HouseOverviewState>(
        'emits [loading, failure] '
        'when getHousesBy fails',
        build: () => houseOverviewBloc,
        setUp: () => when(() => fundaHomesRepository.getHousesBy(city))
            .thenThrow(Exception()),
        act: (bloc) => bloc.add(const HousesByCityRequested(city)),
        expect: () => <HouseOverviewState>[
          const HouseOverviewState(status: HouseOverviewStatus.loading),
          const HouseOverviewState(status: HouseOverviewStatus.failure),
        ],
      );
    });

    group("on DutchCitiesRequested", () {
      const fetchedCities = [
        City(adminName: "adminName", name: "Amsterdam"),
        City(adminName: "adminName", name: "Eindhoven"),
      ];

      setUp(() {
        when(() => fundaHomesRepository.getDutchCities())
            .thenAnswer((_) async => fetchedCities);
      });

      blocTest<HouseOverviewBloc, HouseOverviewState>(
        'emits [loading, loaded] '
        'when getDutchCities succeeds',
        build: () => houseOverviewBloc,
        act: (bloc) => bloc.add(const DutchCitiesRequested()),
        expect: () => <HouseOverviewState>[
          const HouseOverviewState(status: HouseOverviewStatus.loading),
          const HouseOverviewState(
            status: HouseOverviewStatus.loaded,
            cities: fetchedCities,
          ),
        ],
      );

      blocTest<HouseOverviewBloc, HouseOverviewState>(
        'emits [loading, failure] '
        'when getDutchCities fails',
        build: () => houseOverviewBloc,
        setUp: () => when(() => fundaHomesRepository.getDutchCities())
            .thenThrow(Exception()),
        act: (bloc) => bloc.add(const DutchCitiesRequested()),
        expect: () => <HouseOverviewState>[
          const HouseOverviewState(status: HouseOverviewStatus.loading),
          const HouseOverviewState(status: HouseOverviewStatus.failure),
        ],
      );
    });
  });
}
