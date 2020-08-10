import 'package:flutter/material.dart';
import 'package:gym/blocs/base_bloc.dart';

class BaseBlocProvider extends InheritedWidget {
  final BaseBloc _baseBloc = BaseBloc();

  BaseBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static BaseBloc getHomeBloc(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<BaseBlocProvider>())
          ._baseBloc;
}
