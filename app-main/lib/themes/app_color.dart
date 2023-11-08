import 'package:flutter/material.dart';

class AppColor {
  // NEW
  static Gradient primaryGradient = LinearGradient(colors: [
    AppColor.primaryBlue,
    AppColor.primaryPurple,
  ]);
  static Color primaryBlue = const Color.fromRGBO(81, 132, 220, 1);
  static Color primaryWhite = const Color.fromARGB(255, 255, 255, 255);
  static Color primaryPurple = const Color.fromRGBO(137, 125, 215, 1);
  static Color primaryPink = const Color.fromRGBO(232, 49, 112, 1);
  static Color primaryYellow = const Color.fromRGBO(255, 200, 3, 1);
  static Color primaryGrey = const Color.fromRGBO(120, 120, 120, 1);
  static Color primaryGreen = Color.fromRGBO(64, 210, 96, 1);
  static Color primaryOrange = const Color(0xFFFF8642);
  static Color lightPurple = Color.fromARGB(255, 245, 242, 255);
  static Color lightBlue = Color.fromARGB(255, 31, 109, 211);
  static Color lightRed = Color.fromRGBO(245, 97, 97, 1);
  static Color lightGrey = Color.fromARGB(255, 156, 156, 156);
  static Color primaryText = Color.fromRGBO(59, 76, 105, 1);
  static Color lightText = Color.fromARGB(255, 151, 151, 151);

  // STATISTIC CARDS COLOR
  static Color working_days = Color.fromRGBO(51, 33, 253, 1);
  static Color working_hours = Color.fromRGBO(249, 177, 20, 1);
  static Color leave_requests = Color.fromRGBO(229, 83, 83, 1);
  static Color hours_off = Color.fromRGBO(58, 207, 171, 1);
  static Color ot_requests = Color.fromRGBO(23, 208, 74, 1);
  static Color ot_hours = Color.fromRGBO(255, 134, 66, 1);
  static Color late_arrival = Color.fromRGBO(31, 121, 237, 1);
  static Color early_leaving = Color.fromRGBO(116, 83, 249, 1);

  /// Color Tab
  static Color colorTabChoose = const Color(0xFF5184DC);
  static Color colorTextChoose = const Color(0xFFFFFFFF);
  static Color colorTextNotChoose = const Color(0xFF000000).withOpacity(0.6);

  /// Color Button
  static Color colorButtonPending = const Color(0xFFF9E968);
  static Color colorButtonApproved = const Color(0xFF89F69B);
  static Color colorButtonReject = const Color(0xFFF68F89);

  /// Color card Statistics Manage
  static Color colorStatisticsCheckinToday = const Color(0xFF1ADB67);
  static Color colorStatisticsLateToday = const Color(0xFFFF6565);
  static Color colorStatisticsAbsentToday = const Color(0xFFFF8E4F);
  static Color colorStatisticsCasualLeaveToday = const Color(0xFF55AFF0);
  static Color colorStatisticsCheckinMonth = const Color(0xFF3321FD);
  static Color colorStatisticsLateMonth = const Color(0xFF3399FF);
  static Color colorStatisticsAbsentMonth = const Color(0xFFF9B114);
  static Color colorStatisticsCasualLeaveMonth = const Color(0xFFE55353);

  /// Color Icon Profile
  static Color colorIconProfile = const Color(0xFF000000);

  // OLD
  static Color colorIcon = const Color(0xff920A0A);
  static Color colorIconGreyLight = Colors.black26;
  static Color colorIconGreyDark = Colors.black87;
  static Color colorTextGreyLight = Colors.black54;
  static Color colorTextGreyDark = Colors.black87;
  static Color colorBackgroundGreyLight = const Color(0xFFF3F1EF);
  static Color colorBackgroundHome = const Color(0xffEEF6EE);
  static Color colorBackgorundButton = const Color(0xff44A047);
  static Color colorBorderTextFied = const Color(0xffEEF6EE);
  static Color colorBackgorundTextFied =
      const Color(0xff44A047).withOpacity(0.1);
  static Color colorBackgroundTitleTable = const Color(0xFFFBF9FB);

  /// Color Manage Screen
  static Color colorCardAttendanceCheckIn = const Color(0xFFF6A4A4);
  static Color colorCardAttendanceLate = const Color(0xFF95DA5F);
  static Color colorCardAttendanceCasualLeave = const Color(0xFF7CB3ED);
  static Color colorCardManageStaff = const Color(0xFFF8EB7F);
  static Color colorCardManageDepartment = const Color(0xFF00FFD1);
  static Color colorCardManageShift = const Color(0xFFFC6F6F);
  static Color colorCardDashboardStatistics = const Color(0xFFFFC368);
  static Color colorCardProfileCompany = const Color(0xFFCAFF86);
  static Color colorCardLeaveRequests = const Color(0xFF8668FF);
  static Color colorCardOvertimeRequests = const Color(0xFFFC8E6B);
  static Color colorCardCompanySettings = const Color(0xFFE95D5D);

  /// Color text time
  static Color colorTextTimeNormal = const Color(0xFF7DE28A);
  static Color colorTextTimeLate = const Color(0xFFE83170);
  static Color colorTextWorkingHrs = const Color(0xFFF16976);

  // Start set theme defalut
  static setModeDefault() {
    primaryBlue = const Color.fromRGBO(81, 132, 220, 1);
    primaryPurple = const Color.fromRGBO(137, 125, 215, 1);
    primaryPink = const Color.fromRGBO(232, 49, 112, 1);
    primaryYellow = const Color.fromRGBO(255, 200, 3, 1);
    primaryGrey = const Color.fromRGBO(120, 120, 120, 1);

    colorIcon = const Color(0xff920A0A);
    colorIconGreyLight = Colors.black26;
    colorIconGreyDark = Colors.black87;
    colorTextGreyLight = Colors.black54;
    colorTextGreyDark = Colors.black87;
    colorBackgroundGreyLight = const Color(0xFFF3F1EF);
    colorBackgroundHome = const Color(0xffEEF6EE);
    colorBackgorundButton = const Color(0xff44A047);
    colorBorderTextFied = const Color(0xff44A047);
    colorBackgorundTextFied = const Color(0xff44A047).withOpacity(0.1);
  }
  // End set theme defalut

  // Start set theme dark
  static setModeDark() {
    primaryBlue = const Color.fromRGBO(81, 132, 220, 1);
    primaryPurple = const Color.fromRGBO(137, 125, 215, 1);
    primaryPink = const Color.fromRGBO(232, 49, 112, 1);
    primaryYellow = const Color.fromRGBO(255, 200, 3, 1);
    primaryGrey = const Color.fromRGBO(120, 120, 120, 1);

    colorIcon = const Color(0xff007aff);
    colorIconGreyLight = Colors.white54;
    colorIconGreyDark = Colors.white;
    colorTextGreyLight = Colors.white54;
    colorTextGreyDark = Colors.white;
    colorBackgroundGreyLight = const Color(0xFF1C1C1E);
    colorBackgroundHome = const Color(0xff0b0b0c);
    colorBackgorundButton = const Color(0xff007aff);
    colorBorderTextFied = const Color(0xff007aff);
    colorBackgorundTextFied = const Color(0xff0b0b0c).withOpacity(0.2);
  }
  // End set theme dark

  // Start set theme blue sky
  static setModeBlueSky() {
    primaryBlue = const Color.fromRGBO(81, 132, 220, 1);
    primaryPurple = const Color.fromRGBO(137, 125, 215, 1);
    primaryPink = const Color.fromRGBO(232, 49, 112, 1);
    primaryYellow = const Color.fromRGBO(255, 200, 3, 1);
    primaryGrey = const Color.fromRGBO(120, 120, 120, 1);

    colorIcon = const Color(0xff920A0A);
    colorIconGreyLight = Colors.black26;
    colorIconGreyDark = Colors.black87;
    colorTextGreyLight = Colors.black54;
    colorTextGreyDark = Colors.black87;
    colorBackgroundGreyLight = const Color(0xFFF3F1EF);
    colorBackgroundHome = const Color(0xffEEF3F6);
    colorBackgorundButton = const Color(0xff007aff);
    colorBorderTextFied = const Color(0xff007aff);
    colorBackgorundTextFied = const Color(0xff007aff).withOpacity(0.1);
  }
  // End set theme blue sky
}
