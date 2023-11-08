import 'package:app_work_log/modules/account/provider/overtime_request_history_provider.dart';
import 'package:app_work_log/modules/home/models/statistic_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OvertimeRequestHistoryController extends GetxController {
  var dateGetOvertimeRequest = Rx<DateTime>(DateTime.now());

  var checkFilterOvertimeRequest = false.obs;
  var datesGetOvertimeRequest = "".obs;

  Rx<DateTime> advancedTimeStart = DateTime.now().obs;
  Rx<DateTime> advancedTimeEnd = DateTime.now().obs;

  var overtimeRequestHistory = [].obs;

  var overtimeStatistic = StatisticModel().obs;

  var overtimeRequest = 0.obs;
  var overtimeHours = 0.0.obs;

  @override
  void onInit() {
    super.onInit();

    DateTime now = DateTime.now();
    advancedTimeStart.value = DateTime(now.year, now.month, now.day, 0, 0);
    advancedTimeEnd.value = DateTime(now.year, now.month, now.day, 23, 59);

    callApiGetOvertimeRequestHistory(
        timeStart: DateTime(dateGetOvertimeRequest.value.year,
            dateGetOvertimeRequest.value.month),
        timeEnd: DateTime(dateGetOvertimeRequest.value.year,
            dateGetOvertimeRequest.value.month + 1));

    callApiGetOvertimeStatistic(
        timeStart: DateTime(dateGetOvertimeRequest.value.year,
            dateGetOvertimeRequest.value.month),
        timeEnd: DateTime(dateGetOvertimeRequest.value.year,
            dateGetOvertimeRequest.value.month + 1));
  }

  callApiGetOvertimeStatistic(
      {required DateTime timeStart, required DateTime timeEnd}) async {
    overtimeStatistic.value = await OvertimeRequestHistoryProvider()
        .getStatictisUserLogin(timeStart: timeStart, timeEnd: timeEnd);

    overtimeRequest.value = overtimeStatistic.value.overtimeRequest ?? 1;
    overtimeHours.value = overtimeStatistic.value.overtimeHours ?? 1.2;
  }

  callApiGetOvertimeRequestHistory(
      {required DateTime timeStart, required DateTime timeEnd}) async {
    var result = await OvertimeRequestHistoryProvider()
        .getOvertimeRequestHistory(
            createdAtStart: timeStart, createdAtEnd: timeEnd);

    overtimeRequestHistory.value = result;
  }

  nextDateLeaveRequest() {
    checkFilterOvertimeRequest.value = false;
    dateGetOvertimeRequest.value = DateTime(dateGetOvertimeRequest.value.year,
        dateGetOvertimeRequest.value.month + 1);

    callApiGetOvertimeRequestHistory(
        timeStart: DateTime(dateGetOvertimeRequest.value.year,
            dateGetOvertimeRequest.value.month),
        timeEnd: DateTime(dateGetOvertimeRequest.value.year,
            dateGetOvertimeRequest.value.month + 1));

    callApiGetOvertimeStatistic(
        timeStart: DateTime(dateGetOvertimeRequest.value.year,
            dateGetOvertimeRequest.value.month),
        timeEnd: DateTime(dateGetOvertimeRequest.value.year,
            dateGetOvertimeRequest.value.month + 1));
  }

  backDateLeaveRequest() {
    checkFilterOvertimeRequest.value = false;
    dateGetOvertimeRequest.value = DateTime(dateGetOvertimeRequest.value.year,
        dateGetOvertimeRequest.value.month - 1);

    callApiGetOvertimeRequestHistory(
        timeStart: DateTime(dateGetOvertimeRequest.value.year,
            dateGetOvertimeRequest.value.month),
        timeEnd: DateTime(dateGetOvertimeRequest.value.year,
            dateGetOvertimeRequest.value.month + 1));

    callApiGetOvertimeStatistic(
        timeStart: DateTime(dateGetOvertimeRequest.value.year,
            dateGetOvertimeRequest.value.month),
        timeEnd: DateTime(dateGetOvertimeRequest.value.year,
            dateGetOvertimeRequest.value.month + 1));
  }
}
