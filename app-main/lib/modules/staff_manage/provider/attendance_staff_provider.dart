import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/modules/staff_manage/models/attendance.dart';
import 'package:dio/dio.dart';

class AttendanceStaffProvider extends ServiceProvider {
  AttendanceStaffProvider() : super(provider: apiProvider);

  Future<List<AttendanceModel>> getListCheckInOfStaff(DateTime timeCheckInStart,
      DateTime timeCheckInEnd, int companyId, int userId) async {
    try {
      Response response = await provider.get("${ApiUrl.GET_USER_ATTENDANCE}?time_checkin_start=$timeCheckInStart&time_checkin_end=$timeCheckInEnd&company_id=$companyId&user_id=$userId");
      List<AttendanceModel> attendances = attendanceModalFromJson(response.data["data"]);
      return attendances;
    } catch (e) {
      print("Error: " + e.toString());
    }
    return <AttendanceModel>[];
  }
}
