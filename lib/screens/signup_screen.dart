import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../blocs/user_bloc.dart';
import '../providers/user_bloc_provider.dart';
import '../utils/constants.dart';
import '../utils/navigator_util.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserBlocProvider(
      child: SignUpBase(),
    );
  }
}

class SignUpBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignupDetails(),
    );
  }
}

class SignupDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserBloc _userBloc = UserBlocProvider.getUserBloc(context);
    // SnackbarUtil _snackbarUtil = SnackbarUtil();
    // _snackbarUtil.buildContextSignup = context;
    return Container(
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
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                title(),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 64.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Please enter your mobile number',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          left: 30.0,
                          right: 30.0,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: new EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 2.0, color: Colors.black),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.orange),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide:
                                  BorderSide(width: 2, color: Colors.black),
                            ),
                            hintText: 'Enter number',
                            hintStyle: TextStyle(
                                fontSize: 14.0, fontFamily: "SegoeRegular"),
                          ),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: "SegoeRegular",
                          ),
                          controller: _userBloc.phoneNumberController,
                          onChanged: _userBloc.updateUserPhoneNumber,
                        ),
                      ),
                      // Expanded(
                      //   child: Container(),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 30.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: RaisedButton(
                          color: Colors.purple[900],
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                          ),
                          onPressed: () async {
                            bool isrequested =
                                await _userBloc.requestOTP(context);
                            if (isrequested) {
                              NavigatorUtil navigatorUtil = NavigatorUtil();
                              navigatorUtil.navigateToScreen(
                                  context, '/verification');
                            }
                          },
                          child: Text(
                            'Continue',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget title() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 120.0,
      ),
      child: Text(
        'Kya scene hai',
        style: TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontFamily: "SegoeRegular",
        ),
      ),
    );
  }
}
