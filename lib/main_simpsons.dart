import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_config.dart';
import 'bloc_observer.dart';
import 'pages/home_page.dart';

void main() async {
  AppConfig.create(
    appName: "Simpsons",
    baseUrl: "http://api.duckduckgo.com/?q=simpsons+characters&format=json",
    primaryColor: Colors.blue,
    flavor: Flavor.simpsons,
  );
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppConfig.shared.primaryColor,
      ),
      home: const HomePage(),
    );
  }
}
