import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/overtime_request_manage/models/overtime_request_manage.dart';
import 'package:app_work_log/modules/overtime_request_manage/models/statistic_company.dart';
import 'package:app_work_log/modules/overtime_request_manage/provider/overtime_request_manage_provider.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OverTimeRequestManageController extends GetxController {

  var dateGetLeaveRequest = Rx<DateTime>(DateTime.now());

  var checkFilterLeaveRequest = false.obs;
  var datesGetLeaveRequest = "".obs;
  
  RxString advancedTimeStart = "----/--/--".obs;
  RxString advancedTimeEnd = "----/--/--".obs;
  
  var listOvertimeRequest = <OvertimeRequestManage>[OvertimeRequestManage(id: -1)].obs;

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
    getListOvertimeRequest();
  }

  resetList(){
    listOvertimeRequest.value = [OvertimeRequestManage(id: -1)];
  }

  getListOvertimeRequest() async {
    resetList();
    DateTime timeStart = DateFormat("yyyy/MM/dd").parse(advancedTimeStart.value);
    timeStart = DateTime(timeStart.year, timeStart.month, timeStart.day);

    DateTime timeEnd = DateFormat("yyyy/MM/dd").parse(advancedTimeEnd.value);

    if (advancedTimeStart.value == advancedTimeEnd.value) {}
    timeEnd = timeEnd.add(const Duration(days: 1));
    timeEnd = DateTime(timeEnd.year, timeEnd.month, timeEnd.day);
    listOvertimeRequest.value = await OverTimeRequestProvider().getListOvertimeRequestManage(timeStart, timeEnd, Global.userId);
    getTotalHoursbyDate();
  }

  String setTextfromStatusCode(int status){
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

  Color setColorfromStatusCode(int status){
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

  String convertDurationOvertimeRequest(String duration){
    List<String> components = duration.split(':');
    return "${components[0]}h${components[1]}";
  }

  nextDateOvertimeRequest() async {
    resetList();
    checkFilterLeaveRequest.value = false;
    dateGetLeaveRequest.value =
        dateGetLeaveRequest.value.add(const Duration(days: 1));

    advancedTimeStart.value = DateFormat("yyyy/MM/dd").format(dateGetLeaveRequest.value);
    advancedTimeEnd.value = DateFormat("yyyy/MM/dd").format(dateGetLeaveRequest.value);

    DateTime dateBegin = DateTime(dateGetLeaveRequest.value.year,
        dateGetLeaveRequest.value.month, dateGetLeaveRequest.value.day);

    DateTime dateEnd = DateTime(dateGetLeaveRequest.value.add(const Duration(days: 1)).year,
        dateGetLeaveRequest.value.add(const Duration(days: 1)).month, dateGetLeaveRequest.value.add(const Duration(days: 1)).day);

    listOvertimeRequest.value = await OverTimeRequestProvider().getListOvertimeRequestManage(dateBegin, dateEnd, Global.userId);
    getTotalHoursbyDate();
  }

  backDateOvertimeRequest() async {
    resetList();
    checkFilterLeaveRequest.value = false;
    dateGetLeaveRequest.value = dateGetLeaveRequest.value.subtract(const Duration(days: 1));

    advancedTimeStart.value = DateFormat("yyyy/MM/dd").format(dateGetLeaveRequest.value);
    advancedTimeEnd.value = DateFormat("yyyy/MM/dd").format(dateGetLeaveRequest.value);

    DateTime dateBegin = DateTime(dateGetLeaveRequest.value.year, dateGetLeaveRequest.value.month, dateGetLeaveRequest.value.day);

    DateTime dateEnd = DateTime(dateGetLeaveRequest.value.add(const Duration(days: 1)).year,
        dateGetLeaveRequest.value.add(const Duration(days: 1)).month, dateGetLeaveRequest.value.add(const Duration(days: 1)).day);

    listOvertimeRequest.value = await OverTimeRequestProvider().getListOvertimeRequestManage(dateBegin, dateEnd, Global.userId);
    getTotalHoursbyDate();
  }

  getTotalHoursbyDate() async {
    if (!checkFilterLeaveRequest.value) {
      DateTime dateBegin = DateTime(dateGetLeaveRequest.value.year,
          dateGetLeaveRequest.value.month, dateGetLeaveRequest.value.day);
      DateTime dateEnd = DateTime(dateGetLeaveRequest.value.year,
          dateGetLeaveRequest.value.month, dateGetLeaveRequest.value.day + 1);
      companyStatistic.value = await OverTimeRequestProvider()
          .getCompanyStatistic(dateBegin.toString(), dateEnd.toString(), Global.userId);
    } else {
      DateTime timeStart = DateFormat("yyyy/MM/dd").parse(advancedTimeStart.value);
      timeStart = DateTime(timeStart.year, timeStart.month, timeStart.day);
      DateTime timeEnd = DateFormat("yyyy/MM/dd").parse(advancedTimeEnd.value);
      timeEnd = timeEnd.add(const Duration(days: 1));
      timeEnd = DateTime(timeEnd.year, timeEnd.month, timeEnd.day);
      companyStatistic.value = await OverTimeRequestProvider()
          .getCompanyStatistic(timeStart.toString(), timeEnd.toString(), Global.userId);
    }
  }

  Future<bool> updateOvertimeRequest(String id, int statusCode) async {
    if (statusCode == Numeral.STATUS_CODE_REJECT) {
      checkConfirm.value = true;
      if (textReasonController.value.text.isEmpty) {
        textErrorReason.value = "please_fill_this_field";
        checkConfirm.value = false;
      }
    }
    var result;
    if (checkConfirm.value) {
      result = await OverTimeRequestProvider()
        .updateLeaveRequest(id, statusCode, textReasonController.value.text);
    }
    return result;
  }
}
