import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wars/ModelProvider.dart';
import 'package:flutter_wars/ServiceLocator.dart';
import 'package:flutter_wars/view_models/MainPageViewModel.dart';
import 'package:flutter_wars/view_models/MainPageViewModelRx.dart';
import 'package:flutter_wars/views/MainPage/CharacterView.dart';
import 'package:flutter_wars/views/MainPage/CharacterViewRx.dart';
import 'package:flutter_wars/views/MainPage/FilmsViewRx.dart';
import 'package:flutter_wars/views/MainPage/FilsmView.dart';
import 'package:flutter_wars/views/MainPage/PlanetView.dart';
import 'package:flutter_wars/views/MainPage/PlanetViewRx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class MainPageRx extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();


}

class _MainPageState extends State<MainPageRx>
    with AutomaticKeepAliveClientMixin<MainPageRx> {
  @override
  void initState() {
    super.initState();
    print('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
  }

  @override
  void didUpdateWidget(MainPageRx oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
  }
  @override
  Widget build(BuildContext context) {
    ModelProvider.of(context).firstLoad();
    print('build');
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            key: Key('MainPage'),
            appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Flutter Wars',
                  style: TextStyle(
                    fontFamily: 'Distant Galaxy',
                  ),
                ),
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  indicatorWeight: 1.0,
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(FontAwesomeIcons.film),
                      text: 'Films',
                    ),
                    Tab(
                      icon: Icon(FontAwesomeIcons.users),
                      text: 'Characters',
                    ),
                    Tab(
                      icon: Icon(FontAwesomeIcons.globeAmericas),
                      text: 'Planets',
                    )
                  ],
                )),
            body: TabBarView(
              children: <Widget>[
                FilmViewRx(),
                CharacterViewRx(),
                PlanetViewRx(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColorLight,
                child: Icon(Icons.refresh),
                onPressed: () => ModelProvider.of(context).loadData())));
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose');
  }

  // TODO: implement wantKeepAlive
  @override
  bool get wantKeepAlive => true;
}
