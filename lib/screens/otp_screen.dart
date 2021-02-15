import 'package:flutter/material.dart';
import 'package:gym/blocs/user_bloc.dart';
import 'package:gym/providers/user_bloc_provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UserBlocProvider(
      child: VerificationDetails(),
    );
  }
}

class VerificationDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserBloc _userBloc = UserBlocProvider.getUserBloc(context);
    return Scaffold(
      body: VerificationBody(),
    );
  }
}

class VerificationBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserBloc _userBloc = UserBlocProvider.getUserBloc(context);
    // SnackbarUtil _snackbarUtil = SnackbarUtil();
    // _snackbarUtil.buildContextOTP = context;
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
                otpText(_userBloc),
                changeNumberText(context),
                numberField(context, _userBloc),
                resendText(_userBloc),
                smsView(context, _userBloc),
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
        bottom: 30.0,
      ),
      child: Text(
        'OTP Verification',
        style: TextStyle(
          color: Colors.black,
          fontSize: 26.0,
          fontFamily: "SegoeRegular",
        ),
      ),
    );
  }

  Widget otpText(UserBloc userBloc) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        bottom: 20.0,
      ),
      child: Row(
        children: <Widget>[
          Text(
            'Enter the OTP sent to ${userBloc.userPhoneNumberValue}',
            style: TextStyle(
                color: Color(0xFF707070),
                fontSize: 16,
                fontFamily: "SegoeRegular"),
          ),
        ],
      ),
    );
  }

  Widget changeNumberText(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          bottom: 70.0,
        ),
        child: Row(
          children: <Widget>[
            Text(
              'Change Number',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "SegoeRegular"),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pop(context, false);
      },
    );
  }

  Widget numberField(BuildContext context, UserBloc userBloc) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 30.0,
      ),
      child: PinFieldAutoFill(
        decoration: UnderlineDecoration(
            color: Colors.black,
            textStyle: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily:
                    "SegoeRegular")), // UnderlineDecoration, BoxLooseDecoration or BoxTightDecoration see https://github.com/TinoGuo/pin_input_text_field for more info,
        //currentCode: // prefill with a code
        //onCodeSubmitted: //code submitted callback
        onCodeChanged: userBloc.updateOTP,
        codeLength: 4, //code length, default 6
      ),
    );
  }

  Widget resendText(UserBloc userBloc) {
    userBloc.startTimer(30);
    return StreamBuilder(
        stream: userBloc.timer,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          Color color = Colors.grey;
          if (snapshot.hasData && snapshot.data != null && snapshot.data == 0) {
            color = Colors.black;
          }
          return Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              bottom: 20.0,
            ),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Didn't receive the OTP?",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: "SegoeRegular"),
                  ),
                  GestureDetector(
                    child: Text(
                      " RESEND OTP",
                      style: TextStyle(
                          color: color,
                          fontSize: 14,
                          fontFamily: "SegoeRegular"),
                    ),
                    onTap: () async {
                      if (snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data == 0) {
                        userBloc.startTimer(60);
                        await userBloc.resendOTP(context);
                      }
                    },
                  ),
                  Text(
                    " (0:${snapshot.data})",
                    style: TextStyle(
                        color: Colors.white, fontSize: 14, letterSpacing: 0.5),
                  ),
                ],
              ),
              onTap: () async {
                //await userBloc.resendOTP(context);
                // if (isrequested) {
                //   NavigatorUtil navigatorUtil = NavigatorUtil();
                //   navigatorUtil.navigateToScreen(context, '/registration');
                // }
              },
            ),
          );
        });
  }

  Widget smsView(BuildContext context, UserBloc userBloc) {
    return StreamBuilder(
        stream: userBloc.isOTPDone,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          Color color = Color(0XFFDBDBDB);
          Color textColor = Colors.black;
          if (snapshot.hasData && snapshot.data != null && snapshot.data) {
            textColor = Colors.purple[900];
            color = Colors.white;
          }
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Verify & Proceed',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16.0,
                        fontFamily: "SegoeRegular",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () async {
              // if (snapshot.data) {
              //   await userBloc.verifyOTP(context);
              // }
              await userBloc.verifyOTP(context);
              // if (isrequested && snapshot.data) {
              //   NavigatorUtil navigatorUtil = NavigatorUtil();
              //   navigatorUtil.navigateToScreen(context, '/registration');
              // }
            },
          );
        });
  }
}
