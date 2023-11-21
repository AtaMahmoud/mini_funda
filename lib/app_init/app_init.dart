import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'mini_funda_bloc_observer.dart';

typedef AppBuilder = Widget Function();

void appInit(AppBuilder appBuilder) async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const MiniFundaBlocObserver();
  
  runApp(
    appBuilder(),
  );
}
