import 'package:app_work_log/common/utils/dialog.dart';
import 'package:app_work_log/modules/staff_manage/models/staff.dart';
import 'package:app_work_log/modules/staff_manage/models/statistic.dart';
import 'package:app_work_log/modules/staff_manage/models/time_working_date.dart';
import 'package:app_work_log/modules/staff_manage/provider/workingh_statistics_staff_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WorkingHoursStatisticsStaffController extends GetxController {
  var statistic = StatisticModel().obs;

  Rx<StaffManage> staff = StaffManage().obs;

  var currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;

  RxMap<String, String> sumTime = <String, String>{}.obs;

  var sumTimeonMonth = <TimeWorkingDate>[].obs;

  var monthHeader = 0.obs;
  var yearHeader = 0.obs;

  @override
  void onInit() {
    super.onInit();
    staff.value = Get.arguments;
    getStatisticUserbyDate(getFirstDayofMonth().toString(), getEndDayofMonth().toString());
    getSumTimeWorking();
  }

  getStatisticUserbyDate(String begin, String end) async {
    statistic.value = await WorkingHoursStatisticsStaffProvider()
        .getStatictisUserLogin(staff.value.id.toString(), begin, end);
  }

  getSumTimeWorking() async {
    if(monthHeader.value == 0 || yearHeader.value == 0){
      DateTime now = DateTime.now();
      sumTimeonMonth.value = await WorkingHoursStatisticsStaffProvider()
        .getSumTimeWorking(staff.value.id!.toString(), "${now.year}-${now.month}");
    } else {
      sumTimeonMonth.value = await WorkingHoursStatisticsStaffProvider()
        .getSumTimeWorking(staff.value.id!.toString(), "$yearHeader-$monthHeader");
    }
    for (var item in sumTimeonMonth) {
      String dateTime = DateFormat('yyyy-MM-dd').format(item.date!);
      sumTime[dateTime] = item.time.toString();
    }
  }

  DateTime getFirstDayofMonth(){
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  DateTime getEndDayofMonth(){
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month + 1, 1);
  }
}
