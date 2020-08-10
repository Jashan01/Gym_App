import 'package:flutter/material.dart';

import '../blocs/user_bloc.dart';

class UserBlocProvider extends InheritedWidget {
  final UserBloc _userBloc = UserBloc();

  UserBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static UserBloc getUserBloc(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<UserBlocProvider>())
          ._userBloc;
}
