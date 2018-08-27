import 'package:flutter/material.dart';
import 'package:flutter_wars/ModelProvider.dart';
import 'package:flutter_wars/models/Film.dart';
import 'package:flutter_wars/models/Transaction.dart';
import 'package:flutter_wars/view_models/MainPageViewModel.dart';
import 'package:flutter_wars/view_models/MainPageViewModelRx.dart';
import 'package:flutter_wars/views/styles/StarWarsStyles.dart';
import 'package:scoped_model/scoped_model.dart';

class FilmViewRx extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<Transaction>(
      stream: ModelProvider.of(context).films,
      key: Key('FilViewRx'),
      builder: (BuildContext context, AsyncSnapshot<Transaction> snapshot)
      {
        if(snapshot.data == null) {

          return Center(child: Text('Press to load'));
        }
        if(snapshot.data is TransactionError) {

          var transaction = snapshot.data as TransactionError;
          return new Center(
            child: new Text(transaction.errorMessage),
          );
        }
        if(snapshot.data is TransactionInProcess) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.data is TransactionSuccess) {
          var films = snapshot.data.result;
          return ListView.builder(
            itemCount: films == null ? 0 : films.length,
            itemBuilder: (_, int index) {
              var film = films[index];
              return FilmsListItem(film: film);
            },
          );
          }
      },
    );
  }
}

class FilmsListItem extends StatelessWidget {
  final Film film;

  FilmsListItem({@required this.film});

  @override
  Widget build(BuildContext context) {
    return
      Container(
          color: Colors.white70,
          child:  Column(
              children: <Widget>[
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  title: _title(),
                  subtitle: _subTitle(),
                ),
                Divider(),
              ]
          )
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