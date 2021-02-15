import 'dart:async';
import 'dart:io';

//import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym/models/user_model.dart';
import 'package:gym/utils/permission_util.dart';
// import 'package:package_info/package_info.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

class CommonUtil {
  static final CommonUtil _commonUtil = CommonUtil._();
  factory CommonUtil() => _commonUtil;
  CommonUtil._() {
    _permissionsUtil = PermissionsUtil();
  }

  //DbUtil _dbUtil = DbUtil();
  UserModel _user;
  String _operatingSystem = "";
  String _appVersion = "";
  String _appVersionCode = "";
  String deviceID = "";
  String deviceVersion = "";
  String deviceModel = "";
  //DeviceModel deviceData;
  Map<String, List<String>> vehicleModelBodyTypeMap;
  PermissionsUtil _permissionsUtil;
  // ConnectivityUtil _connectivityUtil = ConnectivityUtil();
  BehaviorSubject<bool> _userLoaded = BehaviorSubject<bool>.seeded(false);
  List<String> contactNumber = [];

  TextEditingController controller = TextEditingController();
  get operatingSystem => _operatingSystem;
  UserModel get user => _user;
  get appVersion => _appVersion;
  get appVersionCode => _appVersionCode;

  final _searchData = BehaviorSubject<String>();
  BehaviorSubject<bool> _isSignedIn = BehaviorSubject<bool>();
  BehaviorSubject<bool> _isInitiallySignedIn = BehaviorSubject<bool>();
  BehaviorSubject<bool> _isDarkMode = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<bool> _isForceUpdate = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<bool> _isUpdateRequired = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<bool> _isSuperUser = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<List<String>> _cities = BehaviorSubject<List<String>>();
  BehaviorSubject<bool> _showMiniLoader = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<String> _countryCode = BehaviorSubject<String>.seeded("+91");
  BehaviorSubject<String> _country = BehaviorSubject<String>.seeded("IN");

  Stream<String> get searchData => _searchData.stream;
  Function(String) get updateSearchData => _searchData.sink.add;
  Stream<bool> get isSignedIn => _isSignedIn.stream;
  Function(bool) get _updateIsSignedIn => _isSignedIn.sink.add;
  Stream<String> get countryCode => _countryCode.stream;
  Function(String) get _updateCountryCode => _countryCode.sink.add;
  Stream<String> get country => _country.stream;
  Function(String) get _updateCountry => _country.sink.add;
  Stream<bool> get showMiniLoader => _showMiniLoader.stream;
  bool get showMiniLoaderLastvalue => _showMiniLoader.value;
  // Function(bool) get _updateShowMiniLoader => _showMiniLoader.sink.add;
  Stream<bool> get isSuperUser => _isSuperUser.stream;
  Function(bool) get updateIsSuperUser => _isSuperUser.sink.add;
  Stream<bool> get isInitiallySignedIn => _isInitiallySignedIn.stream;
  Function(bool) get updateIsInitiallySignedIn => _isInitiallySignedIn.sink.add;
  Stream<bool> get isDarkMode => _isDarkMode.stream;
  Function(bool) get updateIsDarkMode => _isDarkMode.sink.add;
  Stream<bool> get isForceUpdate => _isForceUpdate.stream;
  bool get isForceUpdateValue => _isForceUpdate.value;
  Function(bool) get updateIsForceUpdate => _isForceUpdate.sink.add;
  Function(bool) get updateIsUpdateRequired => _isUpdateRequired.sink.add;
  Stream<bool> get isUpdateRequired => _isUpdateRequired.stream;
  bool get isUpdateRequiredLatValue => _isUpdateRequired.value;
  bool get isSIgnedInLastValue => _isSignedIn.value;
  String get countryCodeValue => _countryCode.value;
  String get countryValue => _country.value;
  Stream<List<String>> get cities => _cities.stream;
  Function(List<String>) get updateCities => _cities.sink.add;
  List<String> get citiesLastValue => _cities.value;
  Stream<bool> get userLoaded => _userLoaded.stream;
  Function(bool) get updateUserLoaded => _userLoaded.sink.add;

  void dispose() {
    _isSignedIn.close();
    _cities.close();
    _isInitiallySignedIn.close();
    _isForceUpdate.close();
    _isSuperUser.close();
    _isUpdateRequired.close();
    _showMiniLoader.close();
    _userLoaded.close();
    _isDarkMode.close();
    _countryCode.close();
    _country.close();
    _searchData.close();
  }

  Future<bool> clearAll() async {
    controller.clear();
    updateSearchData(null);
    return true;
  }

  set updateUser(UserModel user) {
    _user = user;
  }

  void updateIsSignedIn(
    bool isSignedIn,
  ) {
    if (isSignedIn != _isSignedIn.value) {
      _updateIsSignedIn(isSignedIn);
    }
  }

  void updateCountryCode(
    String code,
  ) {
    _updateCountryCode(code);
  }

  void updateCountry(
    String country,
  ) {
    _updateCountry(country);
  }

  void nullifySignedInDetails() {
    updateIsSignedIn(false);
    updateCities(null);
    //updateUser = null;
  }
}
