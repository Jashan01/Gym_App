import 'dart:async';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

import '../utils/snackbar_util.dart';

class PermissionsUtil {
  static final PermissionsUtil _permissionsUtil = PermissionsUtil._();
  factory PermissionsUtil() => _permissionsUtil;
  PermissionsUtil._() {
    _snackbarUtil = SnackbarUtil();
  }

  bool _isLocationPermissionEnabled;
  PermissionStatus _locationPermissionStatus;
  SnackbarUtil _snackbarUtil;
  bool get isLocationPermissionEnabled => _isLocationPermissionEnabled;
  PermissionStatus get locationPermissionStatus => _locationPermissionStatus;
  bool _isContactPermissionEnabled;
  PermissionStatus _contactPermissionStatus;
  bool get isContactPermissionEnabled => _isContactPermissionEnabled;
  PermissionStatus get contactPermissionStatus => _contactPermissionStatus;

  Future<bool> init() async {
    return await _initLocationPermission();
  }

  Future<bool> initContact() async {
    return await _initContactPermission();
  }

  Future<bool> _initLocationPermission() async {
    bool isLocationPermissionEnabled =
        await checkPermission(Permission.location);
    if (isLocationPermissionEnabled) {
      updateLocationPermissionError(PermissionStatus.granted);
    } else {
      requestLocationPermission();
    }
    return isLocationPermissionEnabled;
  }

  Future<bool> _initContactPermission() async {
    bool isContactPermissionEnabled =
        await checkPermission(Permission.contacts);
    if (isContactPermissionEnabled) {
      updateContactPermissionError(PermissionStatus.granted);
    } else {
      requestContactPermission();
    }
    return isContactPermissionEnabled;
  }

  Future<PermissionStatus> requestContactPermission() async {
    PermissionStatus contactPermissionStatus =
        await requestPermission(Permission.contacts);
    updateContactPermissionError(contactPermissionStatus);
    return contactPermissionStatus;
  }

  void updateContactPermissionError(PermissionStatus contactPermissionStatus) {
    _contactPermissionStatus = contactPermissionStatus;
    if (contactPermissionStatus == PermissionStatus.granted) {
      _isContactPermissionEnabled = true;
    } else {
      _isContactPermissionEnabled = false;
      if ((contactPermissionStatus == PermissionStatus.denied ||
              contactPermissionStatus == PermissionStatus.undetermined) &&
          !Platform.isIOS) {
        _snackbarUtil.updateMessageHome('Contact permission denied.');
      }
    }
  }

  Future<PermissionStatus> requestLocationPermission() async {
    PermissionStatus locationPermissionStatus =
        await requestPermission(Permission.location);
    updateLocationPermissionError(locationPermissionStatus);
    return locationPermissionStatus;
  }

  void updateLocationPermissionError(
      PermissionStatus locationPermissionStatus) {
    _locationPermissionStatus = locationPermissionStatus;
    if (locationPermissionStatus == PermissionStatus.granted) {
      _isLocationPermissionEnabled = true;
    } else {
      _isLocationPermissionEnabled = false;
      if ((locationPermissionStatus == PermissionStatus.denied ||
              locationPermissionStatus == PermissionStatus.undetermined) &&
          !Platform.isIOS) {
        //_snackbarUtil.updateMessageSignIn('Location permission denied.');
      }
    }
  }

  Future<bool> checkPermission(Permission permission) async {
    return await permission.isGranted;
  }

  Future<PermissionStatus> requestPermission(Permission permission) async {
    return await permission.request();
  }

  Future<bool> openSettings() {
    return openAppSettings();
  }
}
