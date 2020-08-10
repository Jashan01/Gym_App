import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gym/utils/connectivity_util.dart';
import 'package:gym/utils/navigator_util.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;

class InitBloc {
  static final InitBloc _accountBloc = InitBloc._();
  factory InitBloc() => _accountBloc;
  InitBloc._() {
    // _networkUtil = NetworkUtil();
    _connectivityUtil = ConnectivityUtil();
    // _snackbarUtil = SnackbarUtil();
    // _prefsUtil = PrefsUtil();
    _navigatorUtil = NavigatorUtil();
    // _commonUtil = CommonUtil();
  }

  // NetworkUtil _networkUtil;
  ConnectivityUtil _connectivityUtil;
  // SnackbarUtil _snackbarUtil;
  // PrefsUtil _prefsUtil;
  // CommonUtil _commonUtil;
  NavigatorUtil _navigatorUtil;
  // DbUtil _dbUtil = DbUtil();
  // FcmUtil _fcmUtil = FcmUtil();
  String accessToken, refreshToken;
  bool isVerified = false;
  bool isHome = false;
  int _start = 2;

  final BehaviorSubject<int> _timer = BehaviorSubject<int>.seeded(2);
  final BehaviorSubject<bool> _isTimerRunning =
      BehaviorSubject<bool>.seeded(true);

  Stream<int> get timer => _timer.stream;
  int get timerValue => _timer.stream.value;
  Function(int) get _updateTimer => _timer.sink.add;
  Stream<bool> get isTimerRunning => _isTimerRunning.stream;
  bool get isTimerRunningValue => _isTimerRunning.stream.value;
  Function(bool) get _updateIsTimerRunning => _isTimerRunning.sink.add;

  void dispose() {
    _isTimerRunning.close();
    _timer.close();
  }

  Future<bool> clearAll() async {
    return true;
  }

  void startTimer(BuildContext context, int start) {
    _start = start;
    _updateIsTimerRunning(true);
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) => setState(timer, context));
  }

  void setState(Timer timer, BuildContext context) async {
    if (_start < 1) {
      timer.cancel();
      _updateIsTimerRunning(false);
      await _connectivityUtil.init();
      _navigatorUtil.navigateToScreen(context, '/signup', replace: true);
    } else {
      _start = _start - 1;
      _updateTimer(_start);
    }
  }
}
