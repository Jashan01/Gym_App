import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Crashlytics.instance.enableInDevMode = false;
  // Pass all uncaught errors to Crashlytics.
  //FlutterError.onError = Crashlytics.instance.recordFlutterError;
  //Crashlytics().getVersion();

  // FlutterError.onError = (FlutterErrorDetails details) async {
  //   await Crashlytics.instance.recordFlutterError(details);
  // };
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(App()));
}
