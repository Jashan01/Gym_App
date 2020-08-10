import 'dart:core';
import 'dart:async';
import 'dart:convert';
import 'package:gym/models/user_model.dart';
import 'package:gym/utils/common_util.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class NetworkUtil {
  CommonUtil _commonUtil = CommonUtil();
  bool isProduction = bool.fromEnvironment('dart.vm.product');

  Uri getUri(String path, {Map<String, dynamic> queryParams: const {}}) {
    if (isProduction) {
      return Uri(
        host: Constants.HOST_PROD,
        path: path,
        scheme: Constants.PROTOCOL_PROD,
        queryParameters: queryParams,
      );
    } else {
      return Uri(
        host: Constants.hostDev,
        path: path,
        port: Constants.PORT,
        scheme: Constants.PROTOCOL_DEV,
        queryParameters: queryParams,
      );
    }
  }

  Future<http.Response> requestOTP({UserModel user}) {
    print(getUri(Constants.REQUEST_OTP_API));
    print('Body:${json.encode({
      'username': user.phoneNumber,
    })}');
    return http.post(
      getUri(Constants.REQUEST_OTP_API),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        //'name': user.name,
        'username': user.phoneNumber,
      }),
    );
  }

  Future<http.Response> verifyOTP({String phone, String otp}) {
    print(getUri(Constants.VERIFY_OTP_API));
    print('Body:${json.encode({
      'otp': otp,
      'username': phone,
    })}');
    return http.post(
      getUri(Constants.VERIFY_OTP_API),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'otp': otp,
        'username': phone,
      }),
    );
  }

  // Future<http.Response> resendOTP({String phone}) {
  //   print(getUri(Constants.RESEND_OTP_API));
  //   print('Body:${json.encode({
  //     'phone': phone,
  //   })}');
  //   return http.post(
  //     getUri(Constants.RESEND_OTP_API),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: json.encode({
  //       'phone': phone,
  //     }),
  //   );
  // }
}
