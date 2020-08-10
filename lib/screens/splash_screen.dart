import 'package:flutter/material.dart';
import 'package:gym/blocs/init_bloc.dart';
import 'package:gym/providers/init_bloc_provider.dart';
import 'package:gym/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InitBlocProvider(
      child: SplashScreenDetails(),
    );
  }
}

class SplashScreenDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    InitBloc _initBloc = InitBlocProvider.getInitBloc(context);
    _initBloc.startTimer(context, 2);
    return Scaffold(
      backgroundColor: Color(Constants.BASE_COLOR),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const FractionalOffset(1.0, 0.0),
            end: const FractionalOffset(0.6, 0.8),
            stops: [0.0, 1.0],
            colors: [
              Colors.purple[800],
              Colors.purple[300],
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 120,
                width: 120,
                child: Icon(
                  Icons.directions_run,
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 50.0),
              //   child: Text(
              //     'for the human in you',
              //     style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 18.0,
              //         fontFamily: "SegoeSemibold"),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
