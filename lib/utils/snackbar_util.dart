import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../widgets/app_message.dart';

class SnackbarUtil {
  static final SnackbarUtil _snackbarUtil = SnackbarUtil._();
  factory SnackbarUtil() => _snackbarUtil;
  SnackbarUtil._() {
    _messageHome.listen((data) {
      _showSnackbar(_buildContextHome, data);
    });
    _messageSignup.listen((data) {
      _showSnackbar(_buildContextSignup, data);
    });
    _messageProfile.listen((data) {
      _showSnackbar(_buildContextProfile, data);
    });
    _messageBaseScreen.listen((data) {
      _showSnackbar(_buildContextBaseScreen, data);
    });
    _messageThanksScreen.listen((data) {
      _showSnackbar(_buildContextThanksScreen, data);
    });
    _messageOTP.listen((data) {
      _showSnackbar(_buildContextOTP, data);
    });
  }

  BuildContext _buildContextHome;
  BuildContext _buildContextSignup;
  BuildContext _buildContextOTP;
  BuildContext _buildContextProfile;
  BuildContext _buildContextBaseScreen;
  BuildContext _buildContextThanksScreen;
  set buildContextHome(BuildContext context) => _buildContextHome = context;
  set buildContextSignup(BuildContext context) => _buildContextSignup = context;
  set buildContextOTP(BuildContext context) => _buildContextOTP = context;
  set buildContextProfile(BuildContext context) =>
      _buildContextProfile = context;
  set buildContextBaseScreen(BuildContext context) =>
      _buildContextBaseScreen = context;
  set buildContextThanksScreen(BuildContext context) =>
      _buildContextThanksScreen = context;

  final BehaviorSubject<String> _messageHome = BehaviorSubject<String>();
  Function(String) get updateMessageHome => _messageHome.sink.add;
  final BehaviorSubject<String> _messageSignup = BehaviorSubject<String>();
  Function(String) get updateMessageSignup => _messageSignup.sink.add;
  final BehaviorSubject<String> _messageOTP = BehaviorSubject<String>();
  Function(String) get updateMessageOTP => _messageOTP.sink.add;
  final BehaviorSubject<String> _messageProfile = BehaviorSubject<String>();
  Function(String) get updateMessageProfile => _messageProfile.sink.add;
  final BehaviorSubject<String> _messageBaseScreen = BehaviorSubject<String>();
  Function(String) get updateMessageBaseScreen => _messageBaseScreen.sink.add;
  final BehaviorSubject<String> _messageThanksScreen =
      BehaviorSubject<String>();
  Function(String) get updateMessageThanksScreen =>
      _messageThanksScreen.sink.add;

  Future _showSnackbar(BuildContext context, String message) {
    if (context != null) {
      AppMessage appMessage = AppMessage(message);
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(appMessage.snackBar);
    }
    return null;
  }

  void displaySnackbar(BuildContext context, String message) {
    _showSnackbar(context, message);
  }

  void dispose() {
    _messageHome.close();
    _messageSignup.close();
    _messageProfile.close();
    _messageBaseScreen.close();
    _messageThanksScreen.close();
    _messageOTP.close();
  }
}
