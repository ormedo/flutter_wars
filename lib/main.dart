import 'package:flutter_wars/ModelProvider.dart';
import 'package:flutter_wars/ServiceLocator.dart';
import 'package:flutter_wars/services/IStarWarsApi.dart';
import 'package:flutter_wars/services/IStarWarsApiRx.dart';
import 'package:flutter_wars/services/SwapiRx.dart';
import 'package:flutter_wars/view_models/CharacterDetailPageViewModel.dart';
import 'package:flutter_wars/view_models/MainPageViewModelRx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wars/services/Swapi.dart';
import 'package:flutter_wars/view_models/MainPageViewModel.dart';
import 'package:flutter_wars/views/MainPage/MainPageRx.dart';

void main() {
  sl.registerSingleton<IStarWarsApi>(new Swapi());
  sl.registerLazySingleton(() => new MainPageViewModel());
  sl.registerLazySingleton(() => new CharacterDetailPageViewModel());
  //Rx registration
  sl.registerSingleton<IStarWarsApiRx>(new SwapiRx());
  sl.registerLazySingleton(() =>new  MainPageViewModelRx());
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ModelProvider(
        child: MaterialApp(
      title: 'Flutter Wars',
      theme: ThemeData.dark(),
      //home: new MainPage(),
      home: MainPageRx(),
    ));
  }
}
