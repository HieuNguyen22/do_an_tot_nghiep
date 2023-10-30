import 'package:attendance_fast/modules/account/views/account_view.dart';
import 'package:attendance_fast/modules/attendance/views/attendance_view.dart';
import 'package:attendance_fast/modules/manage/views/manage_view.dart';
import 'package:attendance_fast/modules/notification/views/notification_view.dart';
import 'package:attendance_fast/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class HomeFunc {
  static Widget getBody(int selectedIndex, int roleCode) {
    if (roleCode == 2 || roleCode == 3) {
      if (selectedIndex == 0) {
        return const HomeView();
      } else if (selectedIndex == 1) {
        return AttendanceView();
      } else if (selectedIndex == 2) {
        return const ManageView();
      } else if (selectedIndex == 3) {
        return const NotificationView();
      } else {
        return const AccountView();
      }
    } else {
      if (selectedIndex == 0) {
        return const HomeView();
      } else if (selectedIndex == 1) {
        return AttendanceView();
      } else if (selectedIndex == 2) {
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
