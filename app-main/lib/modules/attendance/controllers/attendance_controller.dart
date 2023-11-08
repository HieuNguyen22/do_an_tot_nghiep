import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/utils/dialog.dart';
import 'package:app_work_log/modules/attendance/models/attendance_model.dart';
import 'package:app_work_log/modules/attendance/provider/attendance_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class AttendanceController extends GetxController {
  RxString displayedChosenTime = "--/----".obs;
  RxString chosenTime = "--/----".obs;

  RxString advancedTimeStart = "----/--/--".obs;
  RxString advancedTimeEnd = "----/--/--".obs;

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  RxList fetchedListCheckIn = [].obs;

  @override
  void onInit() {
    super.onInit();
    DateTime now = DateTime.now();
    chosenTime.value = DateFormat("MMMM yyyy").format(now);
    displayedChosenTime.value = chosenTime.value;

    advancedTimeStart.value = DateFormat("yyyy/MM/dd").format(now);
    advancedTimeEnd.value = DateFormat("yyyy/MM/dd").format(now);

    callApiGetListCheckIn();
  }

  callApiGetListCheckIn() async {
    int endMonth = 0;
    int endYear = 0;

    List<String> parts = chosenTime.value.split(" ");

    int startMonth = months.indexOf(parts[0]) + 1;
    int startYear = int.parse(parts[1]);

    if (startMonth == 12) {
      endMonth = 1;
      endYear = startYear + 1;
    } else {
      endMonth = startMonth + 1;
      endYear = startYear;
    }

    NumberFormat("00").format(startMonth);
    NumberFormat("00").format(endMonth);

    String startParam = "$startYear-$startMonth-01 00:00:00";
    String endParam = "$endYear-$endMonth-01 00:00:00";

    showLoading();
    List<dynamic> result = await AttendanceProvider()
        .getListCheckIn(timeCheckInStart: startParam, timeCheckInEnd: endParam, userId: Global.userId.toString());
    closeLoading();

    fetchedListCheckIn.value = result;
  }

  callApiGetListCheckInAdvanced() async {
    String startParam = "$advancedTimeStart 00:00:00";
    String endParam = "$advancedTimeEnd 23:59:00";

    List<dynamic> result = await AttendanceProvider()
        .getListCheckIn(timeCheckInStart: startParam, timeCheckInEnd: endParam, userId: Global.userId.toString());

    fetchedListCheckIn.value = result;
  }

  updateDisplayedChosenTimeAdvanced() {
    displayedChosenTime.value =
        "${advancedTimeStart.value} - ${advancedTimeEnd.value}";
  }

  getNextMonth() {
    List<String> timeParts = chosenTime.value.split(" ");
    String chosenMonth = timeParts[0];
    String chosenYear = timeParts[1];

    int monthIndex = months.indexOf(chosenMonth);
    if (monthIndex == 11) {
      chosenMonth = months[0];
      chosenYear = (int.parse(chosenYear) + 1).toString();
    } else {
      chosenMonth = months[monthIndex + 1];
    }

    chosenTime.value = "${chosenMonth} ${chosenYear}";
    displayedChosenTime.value = chosenTime.value;

    callApiGetListCheckIn();
  }

  getPreviousMonth() {
    List<String> timeParts = chosenTime.value.split(" ");
    String chosenMonth = timeParts[0];
    String chosenYear = timeParts[1];

    int monthIndex = months.indexOf(chosenMonth);
    if (monthIndex == 0) {
      chosenMonth = months[11];
      chosenYear = (int.parse(chosenYear) - 1).toString();
    } else {
      chosenMonth = months[monthIndex - 1];
    }

    chosenTime.value = "${chosenMonth} ${chosenYear}";
    displayedChosenTime.value = chosenTime.value;

    callApiGetListCheckIn();
  }
}
