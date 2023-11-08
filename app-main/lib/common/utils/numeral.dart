import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';

class Numeral {
  /// Index BottomNavigationBar
  static int SCREEN_HOME = 0;
  static int SCREEN_ATTENDANCE = 1;
  static int SCREEN_MANAGE = 2;
  static int SCREEN_NOTIFICATION = 3;
  static int SCREEN_PROFILE = 4;

  /// Index select Manage
  static int SELECT_ATTENDANCE_CHECKIN = 0;
  static int SELECT_ATTENDANCE_LATE = 1;
  static int SELECT_ATTENDANCE_CASUAL_LEAVE = 2;
  static int SELECT_DASHBOARD_STATISTICS = 3;
  static int SELECT_LEAVE_REQUESTS = 4;
  static int SELECT_OVERTIME_REQUESTS = 5;
  static int SELECT_STAFF = 6;
  static int SELECT_DEPARTMENT = 7;
  static int SELECT_SHIFT = 8;
  static int SELECT_PROFILE_COMPANY = 9;
  static int SELECT_COMPANY_SETTING = 10;

  /// Index DropDown Attendance Manage
  static int SELECT_LIST_CHECKIN = 0;
  static int SELECT_LIST_LATE = 1;
  static int SELECT_LIST_CASUAL_LEAVE = 2;

  /// Status code leave request and Overtime request
  static int STATUS_CODE_PENDING = 1;
  static int STATUS_CODE_APPROVED = 2;
  static int STATUS_CODE_REJECT = 3;

  /// Google Map
  static double ZOOM_GOOGLE_MAP = 16;
  static double RADIUS_CHECK = 50;

  /// Date
  static int NUMBER_NEXT_DAY = 1;

  /// Status code user
  static int STATUS_CODE_ACTIVE = 1;
  static int STATUS_CODE_INACTIVE = 2;

  /// Status code response api
  static int STATUS_CODE_API_SUCCESS = 200;

  static int STATUS_CODE_DEFAULT = 1;

  static int CODE_NOT_MANAGER = -1;

  /// Role code user
  static int ROLE_CODE_STAFF = 1;
  static int ROLE_CODE_MANAGER = 2;
  static int ROLE_CODE_ADMIN = 3;

  /// Language
  static int LANGUAGE_EN = 1;
  static int LANGUAGE_VN = 2;
  static int LANGUAGE_JP = 3;

  /// Type Work Company
  static int TYPE_WORK_AT_WORK = 1;
  static int TYPE_WORK_REMOTE = 2;
  static int TYPE_WORK_AT_WORK_REMOTE = 3;

  /// Type Check-in
  static int TYPE_CHECKIN_LOCATION = 1;
  static int TYPE_CHECKIN_WIFI = 2;
  static int TYPE_CHECKIN_LOCATION_WIFI = 3;

  /// Step forgot password
  static int STEP_INPUT_EMAIL = 1;
  static int STEP_INPUT_CODE = 2;
  static int STEP_INPUT_PASSWORD_NEW = 3;

  static double WIDTH_SCREEN = kIsWeb ? (Get.width > Get.height ? (Get.width / Get.height) * 240 : Get.width) : Get.width;

  // Status check-in user
  static int CHECKED_IN_STATUS = 1;
}
