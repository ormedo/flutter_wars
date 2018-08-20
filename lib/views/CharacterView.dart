import 'package:flutter/material.dart';
import 'package:flutter_wars/models/Character.dart';
import 'package:flutter_wars/view_models/MainPageViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class CharacterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainPageViewModel>(
      builder: (context, child, model) {
        if (model.noInternetConnection){
          return new Center(
            child: new Text('No Internet Conection'),
          );
        }

        if (model.isLoadingCharacters) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: model.characters == null ? 0 : model.characters.length,
          itemBuilder: (_, int index) {
            var character = model.characters[index];
            return CharacterListItem(character: character);
          },
        );
      },
    );
  }
}

class CharacterListItem extends StatelessWidget {
  final Character character;

  CharacterListItem({@required this.character});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          title: _title(),
          subtitle: _subTitle(),
        ),
        Divider(),
      ],
    );
  }

  Widget _title() {
    return Text(
      character?.name,
      style: TextStyle(
        //color: StarWarsStyles.titleColor,
        fontWeight: FontWeight.bold,
        // fontSize: StarWarsStyles.titleFontSize,
      ),
    );
  }

  Widget _subTitle() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.calendar_today,
          //  color: StarWarsStyles.subTitleColor,
          //  size: StarWarsStyles.subTitleFontSize,
        ),
        Container(
          margin: const EdgeInsets.only(left: 4.0),
          child: Text(
            character?.birthYear,
            style: TextStyle(
              // color: StarWarsStyles.subTitleColor,
            ),
          ),
        ),
      ],
    );
  }
}