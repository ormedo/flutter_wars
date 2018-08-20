import 'package:flutter/material.dart';
import 'package:flutter_wars/models/Planet.dart';
import 'package:flutter_wars/view_models/MainPageViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class PlanetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainPageViewModel>(
      builder: (context, child, model) {
        if (model.noInternetConnection){
          return new Center(
            child: new Text('No Internet Conection'),
          );
        }

        if (model.isLoadingPlanets) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: model.planets == null ? 0 : model.planets.length,
          itemBuilder: (_, int index) {
            var planet = model.planets[index];
            return PlanetListItem(planet: planet);
          },
        );
      },
    );
  }
}

class PlanetListItem extends StatelessWidget {
  final Planet planet;

  PlanetListItem({@required this.planet});

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
      planet?.name,
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
          Icons.supervisor_account,
          //  color: StarWarsStyles.subTitleColor,
          //  size: StarWarsStyles.subTitleFontSize,
        ),
        Container(
          margin: const EdgeInsets.only(left: 4.0),
          child: Text(
            planet?.population,
            style: TextStyle(
              // color: StarWarsStyles.subTitleColor,
            ),
          ),
        ),
      ],
    );
  }
}