import 'package:flutter/material.dart';
import 'package:gym/screens/base_screen.dart';
import 'package:gym/screens/otp_screen.dart';
import 'package:gym/screens/signup_screen.dart';
import 'package:gym/screens/splash_screen.dart';

class AppRoutes {
  static Route routes(RouteSettings settings) {
    String name = settings.name;

    switch (name) {
      // case '/':
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) {
      //       return LoaderScreen();
      //     },
      //   );
      //   break;
      case '/':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return SplashScreen();
          },
        );
        break;
      case '/signup':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return BaseScreen();
          },
        );
        break;
      case '/base-screen':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return BaseScreen();
          },
        );
        break;
      case '/verification':
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return BaseScreen();
          },
        );
        break;
      default:
        return null;
    }
  }
}
