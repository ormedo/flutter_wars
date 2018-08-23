import 'package:flutter_wars/models/Character.dart';
import 'package:scoped_model/scoped_model.dart';

class CharacterDetailPageViewModel extends Model {
  Character _character;
  Character get films => _character;
  set character(Character value) {
    _character = value;
    notifyListeners();
  }
}