import 'package:flutter/material.dart';
import 'package:flutter_wars/ServiceLocator.dart';
import 'package:flutter_wars/models/Character.dart';
import 'package:flutter_wars/view_models/CharacterDetailPageViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CharacterDetailPage extends StatefulWidget {
  final Character character;

  CharacterDetailPage({@required this.character});

  @override
  _CharacterDetailPageState createState() => new _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  CharacterDetailPageViewModel model;

  _CharacterDetailPageState({CharacterDetailPageViewModel model}) {
    model == null
        ? this.model = sl.get<CharacterDetailPageViewModel>()
        : this.model = model;
  }

  @override
  void initState() {
    super.initState();
    model.character = widget.character;
  }

  @override
  Widget build(BuildContext context) {
    var linearGradient = new BoxDecoration(
      gradient: new LinearGradient(
          begin: FractionalOffset.centerRight,
          end: FractionalOffset.bottomLeft,
          colors: [Colors.white70, Colors.white]),
    );
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return ScopedModel(
        model: model,
        child: new Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: ScopedModelDescendant(builder: (context, child, model) {
                return new Text(
                  widget.character.name,
                  style: TextStyle(fontFamily: 'Distant Galaxy'),
                );
              })),
          body: new SingleChildScrollView(
              child: new Container(
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
                          "Name", widget.character.name),
                      _buildCharacterCaracteristicRow(
                          "Height", widget.character.height.toString()),
                      _buildCharacterCaracteristicRow(
                          "BirthYear", widget.character.birthYear),
                      _buildCharacterCaracteristicRow(
                          "Eye Color", widget.character.eyeColor),
                      _buildCharacterCaracteristicRow(
                          "Gender", widget.character.gender),
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
