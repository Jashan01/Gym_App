class Constants {
  static final Constants _constants = Constants._();
  factory Constants() => _constants;
  Constants._();

  static const int PORT = 80;
  static const PROTOCOL_DEV = 'http';
  static String hostDev = 'gyms.kyascenehai.co.in'; //'192.168.1.8';
  static const PROTOCOL_PROD = 'http';
  static const String HOST_PROD = 'gyms.kyascenehai.co.in';
  static const String KEY_CURRENT_VERSION = "force_update";
  static const String KEY_UPDATE_REQUIRED = "force_update_required";

  static const DIALOG_TYPE_CONFIRMATION = 'confirmation';

  static const String REQUEST_OTP_API = '/vikas/centraluser/app/otp/generate/';
  static const String VERIFY_OTP_API = '/vikas/centraluser/app/otp/verify/';

  static const int BASE_COLOR = 0xFF4A148C;
  static const int BASE_LIGHT_COLOR = 0xFFAB47BC;
}
