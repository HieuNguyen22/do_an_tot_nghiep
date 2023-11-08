import 'package:app_work_log/modules/dashboard_statistics/models/statistics_company.dart';
import 'package:app_work_log/modules/dashboard_statistics/provider/dashboard_statistics_provider.dart';
import 'package:get/get.dart';

class DashboardStatisticsController extends GetxController {

  var companyStatisticDay = StatisticCompany().obs;
  var companyStatisticWeek = StatisticCompany().obs;
  var companyStatisticMonth = StatisticCompany().obs;

  @override
  void onInit() {
    super.onInit();
    getInfoCompany();
  }

  getInfoCompany() async {
    DateTime timeStart = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
    companyStatisticDay.value = await DashboardStatisticsProvider().getCompanyStatisticbyToday(timeStart.toString());
    companyStatisticWeek.value = await DashboardStatisticsProvider().getCompanyStatisticbyDate(getFirsDayofWeek().toString(), getWeekend().toString());
    companyStatisticMonth.value = await DashboardStatisticsProvider().getCompanyStatisticbyDate(getFirsDayofMonth().toString(), getEndDayofMonth().toString());
  }


  DateTime getFirsDayofWeek(){
    DateTime now = DateTime.now();
    DateTime firstDay = now.weekday == 1 ? now : now.subtract(Duration(days: now.weekday - 1));
    return DateTime(firstDay.year, firstDay.month, firstDay.day);
  }

  DateTime getWeekend(){
    DateTime now = DateTime.now();
    DateTime weekendDay = now.weekday == 7 ? now : now.add(Duration(days: 7 - now.weekday));
    return DateTime(weekendDay.add(const Duration(days: 1)).year, weekendDay.add(const Duration(days: 1)).month, weekendDay.add(const Duration(days: 1)).day);
  }

  DateTime getFirsDayofMonth(){
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  DateTime getEndDayofMonth(){
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month + 1, 1);
  }
}
