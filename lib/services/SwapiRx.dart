import 'dart:convert';
import 'package:flutter_wars/models/Character.dart';
import 'package:flutter_wars/models/Film.dart';
import 'package:flutter_wars/models/Planet.dart';
import 'package:flutter_wars/services/IStarWarsApiRx.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class SwapiRx extends IStarWarsApiRx {
  final _baseUrl = 'https://swapi.co/api';

  @override
  Observable<List<Character>> getCharacters() {
    var httpStream = new Observable(http.get('$_baseUrl/people').asStream());

    return httpStream
        .where(
            (data) => data.statusCode == 200) // only continue if valid response
        .map((response) // convert JSON result in ModelObject
            {
      var data = json.decode(response.body);
      List<dynamic> charactersData = data['results'];
      return charactersData
          .map((ch) => Character(
                name: ch['name'],
                birthYear: ch['birth_year'],
                gender: ch['gender'],
                height: int.parse(ch['height']),
                eyeColor: ch['eye_color'],
              ))
          .toList();
    });
  }

  @override
  Observable<List<Film>> getFilms() {
    var httpStream = new Observable(http.get('$_baseUrl/films').asStream());

    return httpStream
        .where(
            (data) => data.statusCode == 200) // only continue if valid response
        .map((response) // convert JSON result in ModelObject
            {
      var data = json.decode(response.body);
      List<dynamic> filmsData = data['results'];
      return filmsData
          .map((fl) => Film(
                title: fl['title'],
                director: fl['director'],
                producer: fl['producer'],
                releaseDate: DateTime.parse(fl['release_date']),
              ))
          .toList();
    }).doOnDone(()=> print('onDone getFilms'));
  }

  @override
  Observable<List<Planet>> getPlanets() {
    var httpStream = new Observable(http.get('$_baseUrl/planets').asStream());

    return httpStream
        .where(
            (data) => data.statusCode == 200) // only continue if valid response
        .map((response) // convert JSON result in ModelObject
            {
      var data = json.decode(response.body);
      List<dynamic> planetsData = data['results'];
      return planetsData
          .map((pl) => Planet(
                name: pl['name'],
                climate: pl['climate'],
                terrain: pl['terrain'],
                diameter: int.parse(pl['diameter']),
                gravity: pl['gravity'],
                population: pl['population'],
              ))
          .toList();
    });
  }
}
