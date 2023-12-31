import 'dart:convert';
import 'dart:io';

import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/utils/dialog.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/attendance_manage/models/attendance_casual_leave_manage.dart';
import 'package:app_work_log/modules/attendance_manage/models/attendance_checkin_manage.dart';
import 'package:app_work_log/modules/attendance_manage/provider/attendance_manage_provider.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class AttendanceCheckInManageController extends GetxController {
  RxList<String> itemCateAttendance = <String>[
    'checkin'.tr,
    'late_arrival'.tr,
    'casual_leave'.tr,
  ].obs;

  var selectCateAttendance = "".obs;
  var selectDay = Rx<DateTime>(DateTime.now());
  var dayDisplay = Rx<DateTime>(DateTime.now());
  var indexSelect = 0.obs;

  var attendancesCheckIn =
      <AttendanceCheckInManage>[AttendanceCheckInManage(id: -1)].obs;
  var attendancesCheckInLate =
      <AttendanceCheckInManage>[AttendanceCheckInManage(id: -1)].obs;
  var attendancesCasualLeave =
      <AttendanceCasualLeave>[AttendanceCasualLeave(id: -1)].obs;

  var isLoading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var textNameFileCsv = TextEditingController().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    indexSelect.value = Get.arguments;
    callApiChangeCateAttendance();
  }

  callApiChangeCateAttendance() {
    if (indexSelect.value == Numeral.SELECT_LIST_CHECKIN) {
      attendancesCheckIn.value = [AttendanceCheckInManage(id: -1)];
      getAttendanceCheckInbyDate(dayDisplay.value,
          dayDisplay.value.add(Duration(days: Numeral.NUMBER_NEXT_DAY)));
    } else if (indexSelect.value == Numeral.SELECT_LIST_LATE) {
      attendancesCheckInLate.value = [AttendanceCheckInManage(id: -1)];
      getAttendanceCheckInLate(dayDisplay.value,
          dayDisplay.value.add(Duration(days: Numeral.NUMBER_NEXT_DAY)));
    } else if (indexSelect.value == Numeral.SELECT_LIST_CASUAL_LEAVE) {
      attendancesCasualLeave.value = [AttendanceCasualLeave(id: -1)];
      getAttendanceCasualLeave(dayDisplay.value,
          dayDisplay.value.add(Duration(days: Numeral.NUMBER_NEXT_DAY)));
    }
  }

  getAttendanceCheckInbyDate(
      DateTime dateTimeBegin, DateTime dateTimeEnd) async {
    DateTime dateBegin =
        DateTime(dateTimeBegin.year, dateTimeBegin.month, dateTimeBegin.day);
    DateTime dateEnd =
        DateTime(dateTimeEnd.year, dateTimeEnd.month, dateTimeEnd.day);
    attendancesCheckIn.value = await AttendanceCheckInManageProvider()
        .getListAttendanceCheckInbyDate(
            "", dateBegin, dateEnd, Global.companyId.toString());
  }

  getAttendanceCheckInLate(DateTime dateTimeBegin, DateTime dateTimeEnd) async {
    DateTime dateBegin =
        DateTime(dateTimeBegin.year, dateTimeBegin.month, dateTimeBegin.day);
    DateTime dateEnd =
        DateTime(dateTimeEnd.year, dateTimeEnd.month, dateTimeEnd.day);
    attendancesCheckInLate.value = await AttendanceCheckInManageProvider()
        .getListAttendanceCheckInLate(dateBegin, dateEnd);
  }

  getAttendanceCasualLeave(DateTime dateTimeBegin, DateTime dateTimeEnd) async {
    DateTime dateBegin =
        DateTime(dateTimeBegin.year, dateTimeBegin.month, dateTimeBegin.day);
    DateTime dateEnd =
        DateTime(dateTimeEnd.year, dateTimeEnd.month, dateTimeEnd.day);
    attendancesCasualLeave.value = await AttendanceCheckInManageProvider()
        .getListAttendanceCasualLeave(dateBegin, dateEnd);
  }

  String filterHoursfromDateTime(DateTime datetime) {
    String formatTime = DateFormat("HH:mm").format(datetime);
    return formatTime;
  }

  bool checkTimekCheckInisLate(DateTime checkIn, String workTime) {
    DateTime time = DateFormat("HH:mm").parse(workTime);
    DateTime dateTimeWorkingBegin = DateTime(dayDisplay.value.year,
        dayDisplay.value.month, dayDisplay.value.day, time.hour, time.second);
    if (checkIn.compareTo(dateTimeWorkingBegin) <= 0) {
      return true;
    }
    return false;
  }

  Future<void> exportListToCSV() async {
    String csvString = "";
    if (indexSelect.value == Numeral.SELECT_LIST_CHECKIN) {
      List<List<dynamic>> rows = [];
      rows.add(['id_employee'.tr, 'first_name'.tr, 'last_name'.tr, 'checkin'.tr, 'checkout'.tr, 'shift'.tr, 'reason'.tr]);
      for (var attendance in attendancesCheckIn) {
        rows.add([
          attendance.userId,
          attendance.userInfo!.firstName!,
          attendance.userInfo!.lastName!,
          attendance.timeCheckin.toString(),
          attendance.timeCheckout.toString(),
          "${attendance.shiftInfo!.name!} (${attendance.shiftInfo!.timeStart!} - ${attendance.shiftInfo!.timeEnd!})",
          attendance.reason,
        ]);
        csvString = const ListToCsvConverter().convert(rows);
      }
    } else if (indexSelect.value == Numeral.SELECT_LIST_LATE) {
      List<List<dynamic>> rows = [];
        rows.add(['id_employee'.tr, 'first_name'.tr, 'last_name'.tr, 'checkin'.tr, 'checkout'.tr, 'shift'.tr, 'reason'.tr]);
      for (var attendance in attendancesCheckInLate) {
        rows.add([
          attendance.userId,
          attendance.userInfo!.firstName!,
          attendance.userInfo!.lastName!,
          attendance.timeCheckin.toString(),
          attendance.timeCheckout.toString(),
          "${attendance.shiftInfo!.name!} (${attendance.shiftInfo!.timeStart!} - ${attendance.shiftInfo!.timeEnd!})",
          attendance.reason,
        ]);
        csvString = const ListToCsvConverter().convert(rows);
      }
    } else if (indexSelect.value == Numeral.SELECT_LIST_CASUAL_LEAVE) {
      List<List<dynamic>> rows = [];
        rows.add(['id_employee'.tr, 'first_name'.tr, 'last_name'.tr, 'begin'.tr, 'end'.tr, 'total_hours'.tr, 'reason'.tr, 'reason_reject'.tr]);
      for (var attendance in attendancesCasualLeave) {
        rows.add([
          attendance.userId,
          attendance.userInfo!.firstName!,
          attendance.userInfo!.lastName!,
          attendance.timeStart,
          attendance.timeEnd,
          attendance.duration,
          attendance.reason,
          attendance.reasonReject,
        ]);
        csvString = const ListToCsvConverter().convert(rows);
      }
    }

    if (GetPlatform.isWeb) {
      Uint8List bytes = Uint8List.fromList(utf8.encode(csvString));

      await FileSaver.instance.saveFile(
        name:
            textNameFileCsv.value.text, 
        bytes: bytes,
        ext: 'csv',
        mimeType: MimeType.csv,
      );
    } else if (GetPlatform.isAndroid || GetPlatform.isIOS){
      String filePath = "${(GetPlatform.isAndroid ? await getExternalStorageDirectory() : await getApplicationSupportDirectory())!.path}/${textNameFileCsv.value.text}.csv";

      try {
        File file = File(filePath);
        await file.writeAsString(csvString);
        final result = await OpenFile.open(filePath);
        if (result.type != ResultType.done) {
          print('Could not open the file: ${result.message}');
        }
      } catch (e) {
        print("Error writing CSV file: $e");
      }
    }
  }

  String? emptyValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else {
      return null;
    }
  }

  validateConfirm() async {
    final FormState? form = formKey.currentState;
    if (!form!.validate()) {
      print('Form is invalid');
    } else {
      print('Form is valid');
      Get.back();
      exportListToCSV();
    }
  }
}
