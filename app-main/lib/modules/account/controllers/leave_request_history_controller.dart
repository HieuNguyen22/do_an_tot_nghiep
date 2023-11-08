import 'package:app_work_log/modules/account/models/leave_request_model.dart';
import 'package:app_work_log/modules/account/provider/leave_request_history_provider.dart';
import 'package:app_work_log/modules/home/models/statistic_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeaveRequestHistoryController extends GetxController {
  var dateGetLeaveRequest = Rx<DateTime>(DateTime.now());

  var checkFilterLeaveRequest = false.obs;
  var datesGetLeaveRequest = "".obs;

  Rx<DateTime> advancedTimeStart = DateTime.now().obs;
  Rx<DateTime> advancedTimeEnd = DateTime.now().obs;

  var leaveRequestHistory = [].obs;

  var leaveStatistic = StatisticModel().obs;

  var leaveRequest = 0.obs;
  var leaveHours = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    DateTime now = DateTime.now();
    advancedTimeStart.value = DateTime(now.year, now.month, now.day, 0, 0);
    advancedTimeEnd.value = DateTime(now.year, now.month, now.day, 23, 59);

    callApiGetLeaveRequestHistory(
        timeStart: DateTime(
            dateGetLeaveRequest.value.year, dateGetLeaveRequest.value.month),
        timeEnd: DateTime(dateGetLeaveRequest.value.year,
            dateGetLeaveRequest.value.month + 1));

    callApiGetLeaveStatistic(
        timeStart: DateTime(
            dateGetLeaveRequest.value.year, dateGetLeaveRequest.value.month),
        timeEnd: DateTime(dateGetLeaveRequest.value.year,
            dateGetLeaveRequest.value.month + 1));
  }

  callApiGetLeaveStatistic(
      {required DateTime timeStart, required DateTime timeEnd}) async {
    leaveStatistic.value = await LeaveRequestHistoryProvider()
        .getStatictisUserLogin(timeStart: timeStart, timeEnd: timeEnd);

    leaveRequest.value = leaveStatistic.value.leaveRequest ?? 1;
    leaveHours.value = leaveStatistic.value.hoursOff ?? 1.2;
  }

  callApiGetLeaveRequestHistory(
      {required DateTime timeStart, required DateTime timeEnd}) async {
    var result = await LeaveRequestHistoryProvider().getLeaveRequestHistory(
        createdAtStart: timeStart, createdAtEnd: timeEnd);

    leaveRequestHistory.value = result;
  }

  nextDateLeaveRequest() {
    checkFilterLeaveRequest.value = false;
    dateGetLeaveRequest.value = DateTime(
        dateGetLeaveRequest.value.year, dateGetLeaveRequest.value.month + 1);

    callApiGetLeaveRequestHistory(
        timeStart: DateTime(
            dateGetLeaveRequest.value.year, dateGetLeaveRequest.value.month),
        timeEnd: DateTime(dateGetLeaveRequest.value.year,
            dateGetLeaveRequest.value.month + 1));

    callApiGetLeaveStatistic(
        timeStart: DateTime(
            dateGetLeaveRequest.value.year, dateGetLeaveRequest.value.month),
        timeEnd: DateTime(dateGetLeaveRequest.value.year,
            dateGetLeaveRequest.value.month + 1));
  }

  backDateLeaveRequest() {
    checkFilterLeaveRequest.value = false;
    dateGetLeaveRequest.value = DateTime(
        dateGetLeaveRequest.value.year, dateGetLeaveRequest.value.month - 1);

    callApiGetLeaveRequestHistory(
        timeStart: DateTime(
            dateGetLeaveRequest.value.year, dateGetLeaveRequest.value.month),
        timeEnd: DateTime(dateGetLeaveRequest.value.year,
            dateGetLeaveRequest.value.month + 1));

    callApiGetLeaveStatistic(
        timeStart: DateTime(
            dateGetLeaveRequest.value.year, dateGetLeaveRequest.value.month),
        timeEnd: DateTime(dateGetLeaveRequest.value.year,
            dateGetLeaveRequest.value.month + 1));
  }
}
