import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_providers/funda_homes_repository.dart';

class App extends StatelessWidget {
  const App({
    required FundaHomesRepository fundaHomesRepository,
    super.key,
  }) : _fundaHomesRepository = fundaHomesRepository;

  final FundaHomesRepository _fundaHomesRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _fundaHomesRepository,
      child: MaterialApp(
        home: const Placeholder(),
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
      ),
    );
  }
}
