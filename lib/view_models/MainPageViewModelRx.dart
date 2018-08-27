import 'package:flutter_wars/models/Character.dart';
import 'package:flutter_wars/models/Film.dart';
import 'package:flutter_wars/models/Planet.dart';
import 'package:flutter_wars/models/Transaction.dart';
import 'package:flutter_wars/services/IStarWarsApiRx.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_wars/ServiceLocator.dart';
import 'package:flutter/material.dart';

class MainPageViewModelRx  {
  IStarWarsApiRx _api;

  MainPageViewModelRx({IStarWarsApiRx params}) {
    params == null ? _api = sl<IStarWarsApiRx>() : _api = params;
    isFirstLoad = true;
  }
  bool isFirstLoad;
  final _planetSubject =
      new BehaviorSubject<Transaction<List<Planet>>>();
  // Only the observable of the Subject gets published
  Observable<Transaction<List<Planet>>> get planets => _planetSubject.stream;

  final _filmSubject = new BehaviorSubject<Transaction<List<Film>>>();
  // Only the observable of the Subject gets published
  Observable<Transaction<List<Film>>> get films => _filmSubject.stream;

  final _characterSubject =
      new BehaviorSubject<Transaction<List<Character>>>();
  // Only the observable of the Subject gets published
  Observable<Transaction<List<Character>>> get characters =>
      _characterSubject.stream;

  void fetchPlanets() {
    _planetSubject.add(TransactionInProcess<List<Planet>>());
    _planetSubject
        .addStream(_api.getPlanets().distinct().map((List<Planet> response) =>
            TransactionSuccess<List<Planet>>(response)))
        .catchError((error) => _planetSubject.add(
            TransactionError<List<Planet>>(errorMessage: error.toString())));
  }

  void fetchCharacters() {
    _characterSubject.add(TransactionInProcess<List<Character>>());
    _characterSubject
        .addStream(_api.getCharacters().distinct().map(
            (List<Character> response) => TransactionSuccess<List<Character>>(response)))
        .catchError((error) => _characterSubject.add(
            TransactionError<List<Character>>(errorMessage: error.toString())));
  }

  void fetchFilms() {

    _filmSubject.add(TransactionInProcess());
    _filmSubject
        .addStream(_api.getFilms().distinct().map(
            (List<Film> response) => TransactionSuccess<List<Film>>(response)))
        .catchError((error) => _filmSubject
            .add(TransactionError<List<Film>>(errorMessage: error.toString())));
  }
  void firstLoad(){
    if(isFirstLoad){
      loadData();
      isFirstLoad = false;
    }
  }
  void loadData(){
    fetchFilms();
    fetchCharacters();
    fetchPlanets();
  }

}
