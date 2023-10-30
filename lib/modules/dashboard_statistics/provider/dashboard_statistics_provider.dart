import 'package:attendance_fast/common/api/api_base.dart';
import 'package:attendance_fast/common/api/api_url.dart';
import 'package:attendance_fast/modules/dashboard_statistics/models/statistics_company.dart';
import 'package:dio/dio.dart';

class DashboardStatisticsProvider extends ServiceProvider {
  DashboardStatisticsProvider() : super(provider: apiProvider);

  Future<StatisticCompany> getCompanyStatisticbyToday(
      String dateTimeStart) async {
    try {
      Response response = await provider.get(ApiUrl.COMPANY_STATISTIC, data: {
        "time_checkin_start": dateTimeStart,
        "time_start_start": dateTimeStart
      });
      StatisticCompany companyModel =
          statisticCompanyFromJson(response.data["data"]);
      return companyModel;
    } catch (e) {
      print("Error: $e");
    }
    return StatisticCompany();
  }

  Future<StatisticCompany> getCompanyStatisticbyDate(
      String dateTimeStart, String datTimeEnd) async {
    try {
      Response response = await provider.get(ApiUrl.COMPANY_STATISTIC, data: {
        "time_checkin_start": dateTimeStart,
        "time_checkin_end": datTimeEnd,
        "time_start_start": dateTimeStart,
        "time_start_end": datTimeEnd
      });
      StatisticCompany companyModel =
          statisticCompanyFromJson(response.data["data"]);
      return companyModel;
    } catch (e) {
      print("Error: $e");
    }
    return StatisticCompany();
  }
}
