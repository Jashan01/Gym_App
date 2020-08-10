import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gym/models/user_model.dart';
import 'package:gym/utils/connectivity_util.dart';
import 'package:gym/utils/navigator_util.dart';
import 'package:gym/utils/network_util.dart';
import 'package:gym/utils/snackbar_util.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;

class UserBloc {
  static final UserBloc _userBloc = UserBloc._();
  factory UserBloc() => _userBloc;
  UserBloc._() {
    _networkUtil = NetworkUtil();
    _connectivityUtil = ConnectivityUtil();
    _snackbarUtil = SnackbarUtil();
    // _prefsUtil = PrefsUtil();
    _navigatorUtil = NavigatorUtil();
    // _commonUtil = CommonUtil();
  }

  UserModel _user;
  NetworkUtil _networkUtil;
  ConnectivityUtil _connectivityUtil;
  SnackbarUtil _snackbarUtil;
  // PrefsUtil _prefsUtil;
  // CommonUtil _commonUtil;
  NavigatorUtil _navigatorUtil;
  // DbUtil _dbUtil = DbUtil();
  // FcmUtil _fcmUtil = FcmUtil();
  String accessToken, refreshToken;
  bool isVerified = false;
  bool isHome = false;
  int _start = 30;

  TextEditingController phoneNumberController = TextEditingController();

  final BehaviorSubject<String> _userPhoneNumber =
      BehaviorSubject<String>.seeded("");
  final BehaviorSubject<String> _otp = BehaviorSubject<String>.seeded("");
  final BehaviorSubject<int> _timer = BehaviorSubject<int>.seeded(30);
  final BehaviorSubject<bool> _isTimerRunning =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> _isOTPDone = BehaviorSubject<bool>.seeded(false);

  Stream<String> get userPhoneNumber => _userPhoneNumber.stream;
  String get userPhoneNumberValue => _userPhoneNumber.stream.value;
  Function(String) get updateUserPhoneNumber => _userPhoneNumber.sink.add;
  Stream<String> get otp => _otp.stream;
  String get otpValue => _otp.stream.value;
  Function(String) get _updateOTP => _otp.sink.add;
  Stream<int> get timer => _timer.stream;
  int get timerValue => _timer.stream.value;
  Function(int) get _updateTimer => _timer.sink.add;
  Stream<bool> get isTimerRunning => _isTimerRunning.stream;
  bool get isTimerRunningValue => _isTimerRunning.stream.value;
  Function(bool) get _updateIsTimerRunning => _isTimerRunning.sink.add;
  Stream<bool> get isOTPDone => _isOTPDone.stream;
  bool get isOTPDoneValue => _isOTPDone.stream.value;
  Function(bool) get _updateIsOTPDone => _isOTPDone.sink.add;

  void dispose() {
    _userPhoneNumber.close();
    _otp.close();
    _isTimerRunning.close();
    _timer.close();
  }

  Future<bool> clearAll() async {
    return true;
  }

  updateOTP(String otp) {
    _updateOTP(otp);
    if (otpValue.length == 6) {
      _updateIsOTPDone(true);
    } else {
      _updateIsOTPDone(false);
    }
  }

  void startTimer(int start) {
    _start = start;
    _updateIsTimerRunning(true);
    const oneSec = const Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer timer) => setState(timer));
  }

  void setState(Timer timer) {
    //_timerr = timer;
    if (_start < 1) {
      timer.cancel();
      _updateIsTimerRunning(false);
    } else {
      _start = _start - 1;
      _updateTimer(_start);
    }
  }

  Future<bool> requestOTP(BuildContext context) async {
    bool isValid = _initUser();
    print(isValid);
    if (isValid) {
      return await _requestOTPApi(context);
    }
    return false;
  }

  bool _initUser() {
    // if (userNameValue == null || userNameValue.isEmpty) {
    //   updateUserName(null);
    //   _snackbarUtil.updateMessageSignup('Please enter name');
    //   return false;
    // }
    if (userPhoneNumberValue == null ||
        userPhoneNumberValue.isEmpty ||
        userPhoneNumberValue.length != 10) {
      updateUserPhoneNumber(null);
      _snackbarUtil.updateMessageSignup('Please enter 10 digit phone number');
      return false;
    }
    _user = UserModel(
      //name: userNameValue,
      phoneNumber: userPhoneNumberValue,
    );
    return true;
  }

  Future<bool> verifyOTP(BuildContext context) async {
    return await _verifyOTPApi(context);
  }

  Future<bool> resendOTP(BuildContext context) async {
    //return await _resendOTPApi(context);
  }

  Future<bool> _requestOTPApi(BuildContext context) async {
    print(_connectivityUtil.isConnectionActive);
    if (_connectivityUtil.isConnectionActive) {
      try {
        _navigatorUtil.showLoader(context, 'Please wait...');
        http.Response response = await _networkUtil.requestOTP(user: _user);
        _navigatorUtil.hideLoader(context, true);
        print(response.body);
        if (response.statusCode == 500) {
          _snackbarUtil.updateMessageSignup('Something went wrong!');
          return false;
        } else if (response.statusCode == 200) {
          return true;
        } else {
          String responseMap = json.decode(response.body);
          if (responseMap != null) {
            _snackbarUtil.updateMessageSignup(responseMap);
          } else {
            _snackbarUtil.updateMessageSignup(
                'Unable to reach our server. Check network connection');
          }
          return false;
        }
      } catch (ex, t) {
        print(ex);
        print(t);
        _snackbarUtil.updateMessageSignup(ex);
        return false;
      }
    } else {
      _snackbarUtil
          .updateMessageSignup('No network available. Check your connection');
      return false;
    }
  }

  Future<bool> _verifyOTPApi(BuildContext context) async {
    if (_connectivityUtil.isConnectionActive) {
      try {
        _navigatorUtil.showLoader(context, 'Please wait...');
        http.Response response = await _networkUtil.verifyOTP(
            phone: _user.phoneNumber, otp: otpValue);
        _navigatorUtil.hideLoader(context, true);
        print(response.body);
        print(response.statusCode);
        if (response.statusCode == 500) {
          _snackbarUtil.updateMessageOTP('Something went wrong!');
          return false;
        } else if (response.statusCode == 200) {
          _navigatorUtil.navigateToScreen(context, '/base-screen',
              replace: true);
          return true;
        } else {
          Map<dynamic, dynamic> responseMap = json.decode(response.body);
          if (responseMap['msg'] != null) {
            _snackbarUtil.updateMessageOTP(responseMap['msg'].toString());
          } else {
            _snackbarUtil.updateMessageOTP(
                'Unable to reach our server. Check network connection');
          }
          return false;
        }
      } catch (ex, t) {
        print(ex);
        print(t);
        _snackbarUtil.updateMessageOTP(ex);
        return false;
      }
    } else {
      _snackbarUtil
          .updateMessageOTP('No network available. Check your connection');
      return false;
    }
  }
}
