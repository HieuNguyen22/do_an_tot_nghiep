import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/modules/attendance/models/attendance_model.dart';

class AttendanceProvider extends ServiceProvider {
  AttendanceProvider() : super(provider: apiProvider);

  /// Get user infor
  Future<List<dynamic>> getListCheckIn(
      {required String timeCheckInStart, required String timeCheckInEnd, required String userId}) async {
    try {
      Map<String, dynamic> params = {
        "time_checkin_start": timeCheckInStart,
        "time_checkin_end": timeCheckInEnd,
        "user_id": userId
      };
      var response = await provider.get(ApiUrl.GET_USER_ATTENDANCE,
          queryParameters: params);

      var listCheckIn = response.data['data']
          .map((data) => AttendanceModel.fromJson(data))
          .toList();

      return listCheckIn;
    } catch (e) {
      print(e);
    }
    return [];
  }
}
