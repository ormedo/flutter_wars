import 'package:flutter/material.dart';
import 'package:flutter_wars/ServiceLocator.dart';
import 'package:flutter_wars/models/Character.dart';
import 'package:flutter_wars/view_models/CharacterDetailPageViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CharacterDetailPage extends StatelessWidget {

  CharacterDetailPageViewModel model;

  CharacterDetailPage({@required Character character,
      CharacterDetailPageViewModel model}) {
    model == null
        ? this.model = sl.get<CharacterDetailPageViewModel>()
        : this.model = model;
    model.character = character;
  }


  @override
  Widget build(BuildContext context) {
    var linearGradient = BoxDecoration(
      gradient: LinearGradient(
          begin: FractionalOffset.centerRight,
          end: FractionalOffset.bottomLeft,
          colors: [Colors.white70, Colors.white]),
    );
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return ScopedModel(
        model: model,
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: ScopedModelDescendant(builder: (context, child, model) {
                return Text(
                  model.character.name,
                  style: TextStyle(fontFamily: 'Distant Galaxy'),
                );
              })),
          body: new SingleChildScrollView(
              child: Container(
            decoration: linearGradient,
            height: screenHeight,
            width: screenWidth,
            child: ScopedModelDescendant(
              builder: (context, child, model) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildCharacterCaracteristicRow(
                          "Name", model.character.name),
                      _buildCharacterCaracteristicRow(
                          "Height", model.character.height.toString()),
                      _buildCharacterCaracteristicRow(
                          "BirthYear", model.character.birthYear),
                      _buildCharacterCaracteristicRow(
                          "Eye Color", model.character.eyeColor),
                      _buildCharacterCaracteristicRow(
                          "Gender", model.character.gender),
                    ]);
              },
            ),
          )),
        ));
  }

  Widget _buildCharacterCaracteristicRow(String title, String value) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black87),
      ),
      subtitle: Text(
        value,
        style: TextStyle(color: Colors.black87),
      ),
    );
  }
}
