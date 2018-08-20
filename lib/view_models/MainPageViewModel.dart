import 'dart:async';
import 'dart:io';
import 'package:flutter_wars/models/Character.dart';
import 'package:flutter_wars/models/Film.dart';
import 'package:flutter_wars/models/Planet.dart';
import 'package:flutter_wars/services/IStarWarsApi.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_wars/ServiceLocator.dart';


class MainPageViewModel extends Model {

  MainPageViewModel({ IStarWarsApi params }){
    params  == null ? _api = sl<IStarWarsApi>() : _api = params;
  }

  List<Film> _films;
  List<Film> get films => _films;
  set films(List<Film> value) {
    _films = value;
    notifyListeners();
  }

  List<Character> _characters;
  List<Character> get characters => _characters;
  set characters(List<Character> value) {
    _characters = value;
    notifyListeners();
  }

  List<Planet> _planets;
  List<Planet> get planets => _planets;
  set planets(List<Planet> value) {
    _planets = value;
    notifyListeners();
  }

  bool _isLoadingFilms = false;
  bool get isLoadingFilms => _isLoadingFilms;
  set isLoadingFilms(bool value) {
    _isLoadingFilms = value;
    notifyListeners();
  }

  bool _isLoadingCharacters = false;
  bool get isLoadingCharacters => _isLoadingCharacters;
  set isLoadingCharacters(bool value) {
    _isLoadingCharacters = value;
    notifyListeners();
  }

  bool _isLoadingPlanets = false;
  bool get isLoadingPlanets => _isLoadingPlanets;
  set isLoadingPlanets(bool value) {
    _isLoadingPlanets = value;
    notifyListeners();
  }

  bool _noInternetConnection = false;
  bool get noInternetConnection => _noInternetConnection;
  set noInternetConnection(bool value) {
    _noInternetConnection = value;
    notifyListeners();
  }

  IStarWarsApi _api;

  Future fetchFilms() async {
    isLoadingFilms = true;
    noInternetConnection = false;

    try {
      films = await _api?.getFilms();
    } catch (e) {
      if (e is SocketException) noInternetConnection = true;
    }
    isLoadingFilms = false;
  }

  Future fetchCharacters() async {
    isLoadingCharacters = true;
    noInternetConnection = false;

    try {
      characters = await _api?.getCharacters();
    } catch (e) {
      if (e is SocketException) noInternetConnection = true;
    }
    isLoadingCharacters = false;
  }

  Future fetchPlanets() async {
    isLoadingPlanets = true;
    noInternetConnection = false;

    try {
      planets = await _api?.getPlanets();
    } catch (e) {
      if (e is SocketException) noInternetConnection = true;
    }
    isLoadingPlanets = false;
  }
}