import 'package:flutter/material.dart';
import 'package:flutter_wars/ModelProvider.dart';
import 'package:flutter_wars/models/Character.dart';
import 'package:flutter_wars/models/Transaction.dart';
import 'package:flutter_wars/router/FadeRouteAnimation.dart';

import 'package:flutter_wars/view_models/MainPageViewModelRx.dart';
import 'package:flutter_wars/views/CharacterDetail/CharacterDetailPage.dart';
import 'package:flutter_wars/views/styles/StarWarsStyles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CharacterViewRx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Transaction>(
      stream: ModelProvider.of(context).characters,
      key: Key('CharacterView'),
      builder: (BuildContext context, AsyncSnapshot<Transaction> snapshot)
      {
        if(snapshot.data == null) {
          return Center(child: Text('Press to load'));
        }
        if(snapshot.data is TransactionError<List<Character>>) {
          return new Center(
            child: new Text('No Internet Conection'),
          );
        }
        if(snapshot.data is TransactionInProcess<List<Character>>) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.data is TransactionSuccess<List<Character>>) {
          var characters = snapshot.data.result;
          return ListView.builder(
            itemCount: characters == null ? 0 : characters.length,
            itemBuilder: (_, int index) {
              var character = characters[index];
              return CharacterListItem(character: character);
            },
          );
        }
      },
    );
  }
}

class CharacterListItem extends StatelessWidget {
  final Character character;
  CharacterListItem({@required this.character});

  @override
  Widget build(BuildContext context) {
    return new Container(
        key: Key('${character.name}_Key'),
        color: Colors.white70,
        child: Column(children: <Widget>[
          ListTile(
              leading: Icon(
                _affiliationSymbol(),
                color: Theme.of(context).primaryColor,
                size: 40.0,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              title: _title(),
              subtitle: _subTitle(),
              onTap: () => Navigator.of(context).push(new FadeRouteAnimation(
                  builder: (c) {
                    return new CharacterDetailPage(character: character);
                  },
                  settings: new RouteSettings())))
        ]));
  }

  Widget _title() {
    return Text(
      character?.name,
      style: TextStyle(
        color: StarWarsStyles.titleColor,
        fontWeight: FontWeight.bold,
        fontSize: StarWarsStyles.titleFontSize,
      ),
    );
  }

  Widget _subTitle() {
    return Row(
      children: <Widget>[
        Text(
          character?.birthYear,
          style: TextStyle(
            color: StarWarsStyles.subTitleColor,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 6.0),
          child: Icon(
            _genderSymbol(),
            color: StarWarsStyles.subTitleColor.withAlpha(200),
            size: StarWarsStyles.subTitleFontSize,
          ),
        ),
      ],
    );
  }

  IconData _affiliationSymbol() {
    switch (character.name) {
      case 'Luke Skywalker':
        return FontAwesomeIcons.jediOrder;
      case 'C-3PO':
        return FontAwesomeIcons.rebel;
      case 'R2-D2':
        return FontAwesomeIcons.rebel;
      case 'Darth Vader':
        return FontAwesomeIcons.empire;
      case 'Leia Organa':
        return FontAwesomeIcons.galacticRepublic;
      case 'Owen Lars':
        return Icons.face;
      case 'Beru Whitesun lars':
        return Icons.face;
      case 'R5-D4':
        return FontAwesomeIcons.rebel;
      case 'Biggs Darklighter':
        return FontAwesomeIcons.rebel;
      case 'Obi-Wan Kenobi':
        return FontAwesomeIcons.jediOrder;
      default:
        return null;
    }
  }

  IconData _genderSymbol() {
    switch (character.gender) {
      case 'male':
        return FontAwesomeIcons.mars;
      case 'female':
        return FontAwesomeIcons.venus;
      case 'n/a':
        return FontAwesomeIcons.robot;
      default:
        return null;
    }
  }
}
