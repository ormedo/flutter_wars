import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_wars/ServiceLocator.dart';
import 'package:flutter_wars/view_models/MainPageViewModel.dart';
import 'package:flutter_wars/views/MainPage/CharacterView.dart';
import 'package:flutter_wars/views/MainPage/FilsmView.dart';
import 'package:flutter_wars/views/MainPage/PlanetView.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scoped_model/scoped_model.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  _MainPageState({MainPageViewModel model}){
    model == null ? this.model = sl.get<MainPageViewModel>() : this.model = model;
  }

  MainPageViewModel model;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
    loadData();
  }

  Future loadData() async {
    await Future.wait([
      model.fetchFilms(),
      model.fetchCharacters(),
      model.fetchPlanets()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Flutter Wars',
          style: TextStyle(
            fontFamily: 'Distant Galaxy',
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 1.0,
          tabs: <Widget>[
            Tab(icon: Icon(FontAwesomeIcons.film), text: 'Films',),
            Tab(icon: Icon(FontAwesomeIcons.users), text: 'Characters',),
            Tab(icon: Icon(FontAwesomeIcons.globeAmericas), text: 'Planets',)
          ],
        ),
      ),
      body: ScopedModel<MainPageViewModel>(
        model: model,
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            FilmView(),
            CharacterView(),
            PlanetView(),
          ],
        ),
      ),
      floatingActionButton: ScopedModel<MainPageViewModel>(
        model: model,
        child: refreshButton(),
      ),
    );
  }

  Widget refreshButton() {
    return ScopedModelDescendant<MainPageViewModel>(
      builder: (context, child, model) {
        return FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColorLight,
          child: Icon(Icons.refresh),
          onPressed: () => loadData(),

        );
      },
    );
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }
}