import 'dart:async';
import 'package:flutter_wars/ServiceLocator.dart';
import 'package:flutter_wars/services/IStarWarsApi.dart';
import 'package:flutter_wars/views/CharacterView.dart';
import 'package:flutter_wars/views/PlanetView.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wars/services/Swapi.dart';
import 'package:flutter_wars/view_models/MainPageViewModel.dart';
import 'package:flutter_wars/views/FilsmView.dart';
import 'package:scoped_model/scoped_model.dart';



void main()  {
  sl.registerSingleton<IStarWarsApi>(new Swapi());
  sl.registerLazySingleton(() => new MainPageViewModel());

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Wars',
      theme: ThemeData.dark(),
      home: new MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  MainPageViewModel model;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    model = sl.get<MainPageViewModel>();
    tabController = TabController(vsync: this, length: 3);
    loadData();
  }

  Future loadData() async {
    await model.fetchFilms();
    await model.fetchCharacters();
    await model.fetchPlanets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Star Wars',
          style: TextStyle(
            fontFamily: 'Distant Galaxy',
          ),
        ),
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3.0,
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
        if (model.noInternetConnection == false)
          return Container(width: 0.0, height: 0.0,);

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