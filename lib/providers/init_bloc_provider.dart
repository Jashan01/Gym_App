import 'package:flutter/material.dart';
import 'package:gym/blocs/init_bloc.dart';

class InitBlocProvider extends InheritedWidget {
  final InitBloc _initBloc = InitBloc();

  InitBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static InitBloc getInitBloc(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<InitBlocProvider>())
          ._initBloc;
}
