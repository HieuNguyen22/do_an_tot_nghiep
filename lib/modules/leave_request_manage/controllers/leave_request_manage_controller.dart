import 'package:attendance_fast/common/global.dart';
import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/modules/leave_request_manage/models/leave_request_manage.dart';
import 'package:attendance_fast/modules/leave_request_manage/models/statistic_company.dart';
import 'package:attendance_fast/modules/leave_request_manage/provider/leave_request_provider.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeaveRequestManageController extends GetxController {
  var listLeaveRequest = <LeaveRequestManage>[LeaveRequestManage(id: -1)].obs;
  var dateGetLeaveRequest = Rx<DateTime>(DateTime.now());

  var checkFilterLeaveRequest = false.obs;
  var datesGetLeaveRequest = "".obs;

  RxString advancedTimeStart = "----/--/--".obs;
  RxString advancedTimeEnd = "----/--/--".obs;

  var companyStatistic = StatisticCompany().obs;

  var isInputRejectReason = false.obs;
  var textReasonController = TextEditingController().obs;
  var isValidReason = true.obs;
  var isConfirmLeaveRequest = false.obs;

  var textErrorReason = "".obs;
  var checkConfirm = true.obs;

  @override
  void onInit() {
    super.onInit();
    DateTime now = DateTime.now();
    advancedTimeStart.value = DateFormat("yyyy/MM/dd").format(now);
    advancedTimeEnd.value = DateFormat("yyyy/MM/dd").format(now);
    getListLeaveRequest();
  }

  resetList() {
    listLeaveRequest.value = [LeaveRequestManage(id: -1)];
  }

  getListLeaveRequest() async {
    resetList();
    DateTime timeStart =
        DateFormat("yyyy/MM/dd").parse(advancedTimeStart.value);
    timeStart = DateTime(timeStart.year, timeStart.month, timeStart.day);

    DateTime timeEnd = DateFormat("yyyy/MM/dd").parse(advancedTimeEnd.value);

    if (advancedTimeStart.value == advancedTimeEnd.value) {}
    timeEnd = timeEnd.add(const Duration(days: 1));
    timeEnd = DateTime(timeEnd.year, timeEnd.month, timeEnd.day);

    listLeaveRequest.value = await LeaveRequestManageProvider()
        .getListLeaveRequestManage(timeStart, timeEnd);
    getTotalHoursbyDate();
  }

  String formatDateTime(DateTime datetime) {
    return DateFormat("dd MMM, yyyy HH:mm").format(datetime);
  }

  String setTextfromStatusCode(int status) {
    String result = "";
    switch (status) {
      case 1:
        result = "pending".tr;
        break;
      case 2:
        result = "approved".tr;
        break;
      case 3:
        result = "rejected".tr;
        break;
      default:
        break;
    }
    return result;
  }

  Color setColorfromStatusCode(int status) {
    Color result = AppColor.colorButtonPending;
    switch (status) {
      case 1:
        result = AppColor.colorButtonPending;
        break;
      case 2:
        result = AppColor.colorButtonApproved;
        break;
      case 3:
        result = AppColor.colorButtonReject;
        break;
      default:
        break;
    }
    return result;
  }

  nextDateLeaveRequest() async {
    resetList();
    checkFilterLeaveRequest.value = false;
    dateGetLeaveRequest.value =
        dateGetLeaveRequest.value.add(const Duration(days: 1));

    advancedTimeStart.value =
        DateFormat("yyyy/MM/dd").format(dateGetLeaveRequest.value);
    advancedTimeEnd.value =
        DateFormat("yyyy/MM/dd").format(dateGetLeaveRequest.value);

    DateTime dateBegin = DateTime(dateGetLeaveRequest.value.year,
        dateGetLeaveRequest.value.month, dateGetLeaveRequest.value.day);

    DateTime dateEnd = DateTime(
        dateGetLeaveRequest.value.add(const Duration(days: 1)).year,
        dateGetLeaveRequest.value.add(const Duration(days: 1)).month,
        dateGetLeaveRequest.value.add(const Duration(days: 1)).day);

    listLeaveRequest.value = await LeaveRequestManageProvider()
        .getListLeaveRequestManage(dateBegin, dateEnd);
    getTotalHoursbyDate();
  }

  backDateLeaveRequest() async {
    resetList();
    checkFilterLeaveRequest.value = false;
    dateGetLeaveRequest.value =
        dateGetLeaveRequest.value.subtract(const Duration(days: 1));

    advancedTimeStart.value =
        DateFormat("yyyy/MM/dd").format(dateGetLeaveRequest.value);
    advancedTimeEnd.value =
        DateFormat("yyyy/MM/dd").format(dateGetLeaveRequest.value);

    DateTime dateBegin = DateTime(dateGetLeaveRequest.value.year,
        dateGetLeaveRequest.value.month, dateGetLeaveRequest.value.day);

    DateTime dateEnd = DateTime(
        dateGetLeaveRequest.value.add(const Duration(days: 1)).year,
        dateGetLeaveRequest.value.add(const Duration(days: 1)).month,
        dateGetLeaveRequest.value.add(const Duration(days: 1)).day);

    listLeaveRequest.value = await LeaveRequestManageProvider()
        .getListLeaveRequestManage(dateBegin, dateEnd);
    getTotalHoursbyDate();
  }

  getTotalHoursbyDate() async {
    if (!checkFilterLeaveRequest.value) {
      DateTime dateBegin = DateTime(dateGetLeaveRequest.value.year,
          dateGetLeaveRequest.value.month, dateGetLeaveRequest.value.day);
      DateTime dateEnd = DateTime(dateGetLeaveRequest.value.year,
          dateGetLeaveRequest.value.month, dateGetLeaveRequest.value.day + 1);
      companyStatistic.value = await LeaveRequestManageProvider()
          .getCompanyStatistic(dateBegin.toString(), dateEnd.toString());
    } else {
      DateTime timeStart =
          DateFormat("yyyy/MM/dd").parse(advancedTimeStart.value);
      timeStart = DateTime(timeStart.year, timeStart.month, timeStart.day);
      DateTime timeEnd = DateFormat("yyyy/MM/dd").parse(advancedTimeEnd.value);
      timeEnd = timeEnd.add(const Duration(days: 1));
      timeEnd = DateTime(timeEnd.year, timeEnd.month, timeEnd.day);
      companyStatistic.value = await LeaveRequestManageProvider()
          .getCompanyStatistic(timeStart.toString(), timeEnd.toString());
    }
  }

  Future<bool> updateLeaveRequest(String id, int statusCode) async {
    if (statusCode == Numeral.STATUS_CODE_REJECT) {
      checkConfirm.value = true;
      if (textReasonController.value.text.isEmpty) {
        textErrorReason.value = "please_fill_this_field";
        checkConfirm.value = false;
      }
    }
    var result;
    if (checkConfirm.value) {
      result = await LeaveRequestManageProvider()
          .updateLeaveRequest(id, statusCode, textReasonController.value.text);
    }
    return result;
  }
}
