import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/account/views/account_view.dart';
import 'package:app_work_log/modules/attendance/views/attendance_view.dart';
import 'package:app_work_log/modules/manage/views/manage_view.dart';
import 'package:app_work_log/modules/notification/views/notification_view.dart';
import 'package:app_work_log/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class HomeFunc {
  static Widget getBody(int selectedIndex, int roleCode) {
    if (roleCode == Numeral.ROLE_CODE_MANAGER || roleCode == Numeral.ROLE_CODE_ADMIN) {
      if (selectedIndex == Numeral.SCREEN_HOME) {
        return const HomeView();
      } else if (selectedIndex == Numeral.SCREEN_ATTENDANCE) {
        return AttendanceView();
      } else if (selectedIndex == Numeral.SCREEN_MANAGE) {
        return const ManageView();
      } else if (selectedIndex == Numeral.SCREEN_NOTIFICATION) {
        return const NotificationView();
      } else {
        return const AccountView();
      }
    } else {
      if (selectedIndex == Numeral.SCREEN_HOME) {
        return const HomeView();
      } else if (selectedIndex == Numeral.SCREEN_ATTENDANCE) {
        return AttendanceView();
      } else if (selectedIndex == Numeral.SCREEN_NOTIFICATION - 1) {
        return const NotificationView();
      } else {
        return const AccountView();
      }
    }
  }

  static String formatedTime(int secTime) {
    String getParsedTime(String time) {
      if (time.length <= 1) return "0$time";
      return time;
    }

    int day = secTime ~/ 86400;
    int min = (secTime % 86400) ~/ 3600;
    int sec = (secTime % 3600) ~/ 60;
    if (day > 0) {
      return "${getParsedTime(day.toString())} Ngày ${getParsedTime(min.toString())} Giờ ${getParsedTime(sec.toString())} Phút ";
    } else if (min > 0) {
      return "${getParsedTime(min.toString())} Giờ ${getParsedTime(sec.toString())} Phút ";
    } else {
      return "${getParsedTime(sec.toString())} Phút ";
    }
  }

  static getTime(String timeBook) {
    var dateOfBirth = DateTime.parse(timeBook);
    var currentDate = DateTime.now();
    var different = dateOfBirth.difference(currentDate);
    return formatedTime(different.inSeconds);
  }

  static formatTimeToString(date) {
    var inputDate = DateTime.parse(date.toString());
    var outputFormat = DateFormat('HH:mm dd/MM/yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
