import 'package:flutter/material.dart';
import 'package:flutter_wars/models/Character.dart';

class CharacterDetailPage extends StatefulWidget {
  final Character character;

  CharacterDetailPage({@required this.character});

  @override
  _CharacterDetailPage createState() => new _CharacterDetailPage();
}

class _CharacterDetailPage extends State<CharacterDetailPage> {

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
    return new Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: new Text(
              widget.character.name,
              style: TextStyle(fontFamily: 'Distant Galaxy'),
            )),
        body: new SingleChildScrollView(
          child: new Container(
            decoration: linearGradient,
            height: screenHeight,
            width: screenWidth,
            child: new Column(
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
                ]),
          ),
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
