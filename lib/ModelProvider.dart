import 'package:flutter/material.dart';
import 'package:flutter_wars/ServiceLocator.dart';
import 'package:flutter_wars/view_models/MainPageViewModelRx.dart';

class ModelProvider extends InheritedWidget {
  MainPageViewModelRx model;

  ModelProvider({Key key,MainPageViewModelRx model, @required Widget child}):
        super(key: key, child: child){
    model == null ? this.model = sl<MainPageViewModelRx>() : this.model = model;
  }

  static MainPageViewModelRx of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ModelProvider) as ModelProvider)
          .model;

  @override
  bool updateShouldNotify(ModelProvider oldWidget) => false;
}