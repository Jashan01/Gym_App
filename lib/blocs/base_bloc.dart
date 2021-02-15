import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BaseBloc {
  static final BaseBloc _baseBloc = BaseBloc._();
  factory BaseBloc() => _baseBloc;
  BaseBloc._() {
    // _networkUtil = NetworkUtil();
    // _connectivityUtil = ConnectivityUtil();
    // _snackbarUtil = SnackbarUtil();
    // _commonUtil = CommonUtil();
    // _dbUtil = DbUtil();
  }

  // NetworkUtil _networkUtil;
  // ConnectivityUtil _connectivityUtil;
  // SnackbarUtil _snackbarUtil;
  // CommonUtil _commonUtil;
  // DbUtil _dbUtil;
  int start = 0;
  //List<ContactModel> sycnContacts = [];

  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final BehaviorSubject<int> _currentIndex = BehaviorSubject<int>.seeded(0);
  final BehaviorSubject<int> _count = BehaviorSubject<int>.seeded(0);
  final BehaviorSubject<bool> _isProfile = BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> _isSayingThanks =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<BuildContext> _context =
      BehaviorSubject<BuildContext>();
  final BehaviorSubject<bool> _isSingleBackRequired =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<int> _badgeCount = BehaviorSubject<int>.seeded(0);

  Stream<int> get currentIndex => _currentIndex.stream;
  int get currentIndexValue => _currentIndex.stream.value;
  Function(int) get updateCurrentindex => _currentIndex.sink.add;
  Stream<int> get count => _count.stream;
  int get countValue => _count.stream.value;
  Function(int) get updateCount => _count.sink.add;
  Stream<BuildContext> get context => _context.stream;
  BuildContext get contextValue => _context.stream.value;
  Function(BuildContext) get updateContext => _context.sink.add;
  Stream<bool> get isProfile => _isProfile.stream;
  bool get isProfileValue => _isProfile.stream.value;
  Function(bool) get updateIsProfile => _isProfile.sink.add;
  Stream<bool> get isSayingThanks => _isSayingThanks.stream;
  bool get isSayingThanksValue => _isSayingThanks.stream.value;
  Function(bool) get updateIsSayingThanks => _isSayingThanks.sink.add;
  Stream<bool> get isSingleBackRequired => _isSingleBackRequired.stream;
  bool get isSingleBackRequiredValue => _isSingleBackRequired.stream.value;
  Function(bool) get updateIsSingleBackRequired =>
      _isSingleBackRequired.sink.add;
  Stream<int> get badgeCount => _badgeCount.stream;
  int get badgeCountValue => _badgeCount.stream.value;
  Function(int) get updateBadgeCount => _badgeCount.sink.add;

  void dispose() {
    _badgeCount.close();
    _currentIndex.close();
    _count.close();
    _context.close();
    _isProfile.close();
    _isSayingThanks.close();
    _isSingleBackRequired.close();
  }

  Future<bool> clearAll() async {
    updateIsProfile(true);
    return true;
  }

  Future<bool> onWillPop() async {
    print('hlw');
    if (navigatorKey.currentState.canPop()) {
      navigatorKey.currentState.pop();
      updateCount(countValue - 1);
      updateIsProfile(true);
      return false;
    } else {
      if (currentIndexValue != 3) {
        updateCurrentindex(3);
        updateIsProfile(true);
        return false;
      } else if (!isProfileValue) {
        updateIsProfile(true);
        return false;
      } else {
        return true;
      }
    }
  }

  void updateNavigation(int index) {
    updateIsProfile(true);
    for (int i = 0; i < countValue; i++) {
      if (navigatorKey.currentState.canPop()) {
        navigatorKey.currentState.pop();
      }
    }
    updateCurrentindex(index);
    updateCount(0);
  }

  openPage(BuildContext context, Widget screen) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen, maintainState: true));

  void syncData(BuildContext context, int start) {
    //sycnContacts = _commonUtil.contactModelList;
    //startSync(context, start);
  }
}
