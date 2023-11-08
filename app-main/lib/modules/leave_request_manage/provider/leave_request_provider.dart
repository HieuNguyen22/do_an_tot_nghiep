import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/leave_request_manage/models/leave_request_manage.dart';
import 'package:app_work_log/modules/leave_request_manage/models/statistic_company.dart';
import 'package:dio/dio.dart';

class LeaveRequestManageProvider extends ServiceProvider {
  LeaveRequestManageProvider() : super(provider: apiProvider);

  Future<List<LeaveRequestManage>> getListLeaveRequestManage(
      DateTime timeStart, DateTime timeEnd, int? approveId) async {
    try {
      Response? response;
      if (Global.roleCodeUser == Numeral.ROLE_CODE_ADMIN) {
        response = await provider.get(
          "${ApiUrl.CASUAL_LEAVE_OF_COMPANY_ON_DATE}?time_start_start=$timeStart&time_start_end=$timeEnd",
        );
      } else if (Global.roleCodeUser == Numeral.ROLE_CODE_MANAGER) {
        response = await provider
            .get("${ApiUrl.CASUAL_LEAVE_OF_COMPANY_ON_DATE}??time_start_start=$timeStart&time_start_end=$timeEnd&to_approve_id=$approveId");
      }
      List<LeaveRequestManage> leaveRequest =
          leaveRequestManageFromJson(response!.data["data"]);
      return leaveRequest;
    } catch (e) {
      print(e.toString());
    }
    return <LeaveRequestManage>[];
  }

  Future<StatisticCompany> getCompanyStatistic(
      String dateTimeStart, String datTimeEnd, int? approveId) async {
    try {
      Response? response;
      if (Global.roleCodeUser == Numeral.ROLE_CODE_ADMIN) {
        response = await provider.get(ApiUrl.COMPANY_STATISTIC, data: {
        "time_checkin_start": dateTimeStart,
        "time_checkin_end": datTimeEnd,
        "time_start_start": dateTimeStart,
        "time_start_end": datTimeEnd
      });
      } else if (Global.roleCodeUser == Numeral.ROLE_CODE_MANAGER) {
        response = await provider.get(ApiUrl.COMPANY_STATISTIC, data: {
        "time_checkin_start": dateTimeStart,
        "time_checkin_end": datTimeEnd,
        "time_start_start": dateTimeStart,
        "time_start_end": datTimeEnd,
        "to_approve_id": approveId
      });
      }
      StatisticCompany companyModel =
          statisticCompanyFromJson(response!.data["data"]);
      return companyModel;
    } catch (e) {
      print("Error: $e");
    }
    return StatisticCompany();
  }

  Future<bool> updateLeaveRequest(
      String id, int statusCode, String reasonReject) async {
    try {
      Response response =
          await provider.put("${ApiUrl.UPDATE_LEAVE_REQUEST}/$id",
              data: statusCode == Numeral.STATUS_CODE_APPROVED
                  ? {
                      "status_code": statusCode,
                    }
                  : {"status_code": statusCode, "reason_reject": reasonReject});
      return response.data["data"] != null;
    } catch (e) {
      print("Error: " + e.toString());
      return false;
    }
  }
}
