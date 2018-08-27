

import 'package:flutter_wars/models/Character.dart';
import 'package:flutter_wars/models/Film.dart';
import 'package:flutter_wars/models/Planet.dart';
import 'package:rxdart/rxdart.dart';

abstract class IStarWarsApiRx {

  Observable<dynamic> _getData(String url);

  Observable<List<Film>> getFilms();

  Observable<List<Character>> getCharacters();

  Observable<List<Planet>> getPlanets();

}