import 'package:flutter/material.dart';
import 'package:flutter_wars/ModelProvider.dart';
import 'package:flutter_wars/models/Planet.dart';
import 'package:flutter_wars/models/Transaction.dart';
import 'package:flutter_wars/view_models/MainPageViewModel.dart';
import 'package:flutter_wars/view_models/MainPageViewModelRx.dart';
import 'package:flutter_wars/views/styles/StarWarsStyles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class PlanetViewRx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Transaction>(
      stream: ModelProvider.of(context).planets,
      key: Key('PlanetView'),
      builder: (BuildContext context, AsyncSnapshot<Transaction> snapshot)
      {
        if(snapshot.data == null) {
          return Center(child: Text('Press to load'));
        }
        if(snapshot.data is TransactionError) {
          return new Center(
            child: new Text('No Internet Conection'),
          );
        }
        if(snapshot.data is TransactionInProcess) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.data is TransactionSuccess) {
          var planets = snapshot.data.result;
          return ListView.builder(
            itemCount: planets == null ? 0 : planets.length,
            itemBuilder: (_, int index) {
              var planet = planets[index];
              return PlanetListItem(planet: planet);
            },
          );
        }
      },
    );
  }
}


class PlanetListItem extends StatelessWidget {
  final Planet planet;

  PlanetListItem({@required this.planet});

  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white70,
        child: Column(
          children: <Widget>[
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              title: _title(),
              subtitle: _subTitle(),
            ),
            Divider(),
          ],
        ));
  }

  Widget _title() {
    return Text(
      planet?.name,
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
        Icon(
          FontAwesomeIcons.users,
          color: StarWarsStyles.subTitleColor,
          size: StarWarsStyles.subTitleFontSize,
        ),
        Container(
          margin: const EdgeInsets.only(left: 7.0),
          child: Text(
            planet?.population,
            style: TextStyle(
              color: StarWarsStyles.subTitleColor,
            ),
          ),
        ),
      ],
    );
  }
}
