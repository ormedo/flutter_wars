import 'dart:async';

import 'package:flutter_wars/models/Character.dart';
import 'package:flutter_wars/models/Film.dart';
import 'package:flutter_wars/models/Planet.dart';

abstract class IStarWarsApi {

  Future<dynamic> _getData(String url);

  Future<List<Film>> getFilms();

  Future<List<Character>> getCharacters();

  Future<List<Planet>> getPlanets();

}