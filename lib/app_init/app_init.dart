import 'package:flutter/material.dart';

typedef AppBuilder = Widget Function();

void appInit(AppBuilder appBuilder) async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    appBuilder(),
  );
}
