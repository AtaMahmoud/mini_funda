import 'package:equatable/equatable.dart';

import '../models/city.dart';
import '../models/house.dart';
import '../models/house_details.dart';
import 'funda_api_client.dart';

abstract class HomeFetchFailure with EquatableMixin implements Exception {
  const HomeFetchFailure(this.error);

  final Object error;

  @override
  List<Object> get props => [error];
}

class GetHousesByCityFailure extends HomeFetchFailure {
  const GetHousesByCityFailure(super.error);
}

class GetHouseByIdFailure extends HomeFetchFailure {
  const GetHouseByIdFailure(super.error);
}

class GetDutchCitiesFailure extends HomeFetchFailure {
  const GetDutchCitiesFailure(super.error);
}

class FundaHomesRepository {
  const FundaHomesRepository({required FundaApiClient apiClient})
      : _apiClient = apiClient;

  final FundaApiClient _apiClient;

  Future<List<House>> getHousesBy(String city) async {
    try {
      return await _apiClient.getHomesBy(city);
    } catch (e) {
      throw GetHousesByCityFailure(e);
    }
  }

  Future<HouseDetails> getHouseDetailsBy(String id) async {
    try {
      return await _apiClient.getHomeDetailsBy(id);
    } catch (e) {
      throw GetHouseByIdFailure(e);
    }
  }

  Future<List<City>> getDutchCities() async {
    try {
      return await _apiClient.getDutchCities();
    } catch (e) {
      throw GetDutchCitiesFailure(e);
    }
  }
}
