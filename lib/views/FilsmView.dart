import 'package:flutter/material.dart';
import 'package:flutter_wars/models/Film.dart';
import 'package:flutter_wars/view_models/MainPageViewModel.dart';
import 'package:flutter_wars/views/styles/StarWarsStyles.dart';
import 'package:scoped_model/scoped_model.dart';

class FilmView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainPageViewModel>(
      builder: (context, child, model) {
        if (model.noInternetConnection){
            return new Center(
               child: new Text('No Internet Conection'),
          );
        }

        if (model.isLoadingFilms) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: model.films == null ? 0 : model.films.length,
          itemBuilder: (_, int index) {
            var film = model.films[index];
            return FilmsListItem(film: film);
          },
        );
      },
    );
  }
}

class FilmsListItem extends StatelessWidget {
  final Film film;

  FilmsListItem({@required this.film});

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
      film?.title,
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
          Icons.movie,
          color: StarWarsStyles.subTitleColor,
          size: StarWarsStyles.subTitleFontSize,
        ),
        Container(
          margin: const EdgeInsets.only(left: 4.0),
          child: Text(
            film?.director,
            style: TextStyle(
              color: StarWarsStyles.subTitleColor,
            ),
          ),
        ),
      ],
    );
  }
}