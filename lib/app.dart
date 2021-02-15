import 'package:flutter/material.dart';
import 'package:gym/app_routes.dart';
import 'package:gym/utils/constants.dart';

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return Hunik();
  }
}

class Hunik extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: AppRoutes.routes,
      theme: new ThemeData(
        fontFamily: "SegoeRegular",
        primaryColor: Color(Constants.BASE_COLOR),
        primaryTextTheme:
            TextTheme(headline6: TextStyle(color: Color(Constants.BASE_COLOR))),
        primaryIconTheme: IconThemeData(color: Color(Constants.BASE_COLOR)),
      ),
    );
  }
}
