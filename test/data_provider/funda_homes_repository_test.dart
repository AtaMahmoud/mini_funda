import 'package:flutter_test/flutter_test.dart';
import 'package:mini_funda/data_providers/funda_api_client.dart';
import 'package:mini_funda/data_providers/funda_homes_repository.dart';
import 'package:mini_funda/models/city.dart';
import 'package:mini_funda/models/house.dart';
import 'package:mini_funda/models/house_details.dart';
import 'package:mocktail/mocktail.dart';

class MockFundaApiClient extends Mock implements FundaApiClient {}

void main() {
  group('FundaHomesRepository', () {
    late FundaApiClient apiClient;
    late FundaHomesRepository repository;

    setUp(() {
      apiClient = MockFundaApiClient();
      repository = FundaHomesRepository(apiClient: apiClient);
    });

    group("whe calling getHousesBy", () {
      const city = 'Amsterdam';

      setUp(() async {
        when(() => apiClient.getHomesBy(city))
            .thenAnswer((_) async => [House.testInstance()]);

        await repository.getHousesBy(city);
      });

      test("then it should call apiClient.getHomesBy", () {
        verify(() => apiClient.getHomesBy(city)).called(1);
      });

      test('then it should throw exception if apiClient.getHomesBy fails',
          () async {
        when(() => apiClient.getHomesBy(city)).thenThrow(Exception());

        expect(
          () async => repository.getHousesBy(city),
          throwsA(isA<GetHousesByCityFailure>()),
        );
      });
    });

    group("whe calling getHousesBy", () {
      const houseId = "House_id";

      setUp(() async {
        when(() => apiClient.getHomeDetailsBy(houseId))
            .thenAnswer((_) async => HouseDetails.testInstance());

        await repository.getHouseDetailsBy(houseId);
      });

      test("then it should call apiClient.getHomeDetailsBy", () {
        verify(() => apiClient.getHomeDetailsBy(houseId)).called(1);
      });

      test(
          "then it should throw exception if apiClient.getHouseDetailsBy fails",
          () {
        when(() => apiClient.getHomeDetailsBy(houseId)).thenThrow(Exception());

        expect(
          () async => repository.getHouseDetailsBy(houseId),
          throwsA(isA<GetHouseByIdFailure>()),
        );
      });
    });

    group("whe calling getHousesBy", () {
      const houseId = "House_id";

      setUp(() async {
        when(() => apiClient.getHomeDetailsBy(houseId))
            .thenAnswer((_) async => HouseDetails.testInstance());

        await repository.getHouseDetailsBy(houseId);
      });

      test("then it should call apiClient.getHomeDetailsBy", () {
        verify(() => apiClient.getHomeDetailsBy(houseId)).called(1);
      });

      test(
          "then it should throw exception if apiClient.getHouseDetailsBy fails",
          () {
        when(() => apiClient.getHomeDetailsBy(houseId)).thenThrow(Exception());

        expect(
          () async => repository.getHouseDetailsBy(houseId),
          throwsA(isA<GetHouseByIdFailure>()),
        );
      });
    });

    group("whe calling getDutchCities", () {
      setUp(() async {
        when(() => apiClient.getDutchCities()).thenAnswer((_) async => [
              const City(adminName: "adminName", name: "name"),
            ]);

        await repository.getDutchCities();
      });

      test("then it should call apiClient.getDutchCities", () {
        verify(() => apiClient.getDutchCities()).called(1);
      });

      test("then it should throw exception if apiClient.getDutchCities fails",
          () {
        when(() => apiClient.getDutchCities()).thenThrow(Exception());

        expect(
          () async => repository.getDutchCities(),
          throwsA(isA<GetDutchCitiesFailure>()),
        );
      });
    });
  });
}
