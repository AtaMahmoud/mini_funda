import 'package:flutter/material.dart';
import 'package:mini_funda/views/app.dart';

import 'app_init/app_init.dart';
import 'data_providers/funda_api_client.dart';
import 'data_providers/funda_homes_repository.dart';
import 'data_providers/key_storage.dart';

void main() {
  appInit(() {
    final keyStorage = InMemoryKeyStorage();
    keyStorage.savekey(const String.fromEnvironment('FUNDA_API_KEY'));

    final apiClient = FundaApiClient.dev(keyProvider: keyStorage.readkey);

    final fundaHomesRepository = FundaHomesRepository(apiClient: apiClient);

    return App(fundaHomesRepository: fundaHomesRepository);
  });
}
