import 'package:attendance_fast/common/api/api_base.dart';
import 'package:attendance_fast/common/api/api_url.dart';
import 'package:attendance_fast/modules/account/models/leave_request_model.dart';
import 'package:attendance_fast/modules/home/models/statistic_model.dart';

class LeaveRequestHistoryProvider extends ServiceProvider {
  LeaveRequestHistoryProvider() : super(provider: apiProvider);

  /// Get user leave request
  Future<List<dynamic>> getLeaveRequestHistory(
      {required DateTime createdAtStart,
      required DateTime createdAtEnd}) async {
    Map<String, dynamic> params = {
      "created_at_start": createdAtStart,
      "created_at_end": createdAtEnd,
    };
    try {
      var response = await provider.get(ApiUrl.GET_USER_LEAVE_REQUEST,
          queryParameters: params);

      var listLeaveRequest = response.data['data']
          .map((data) => LeaveRequestModel.fromJson(data))
          .toList();

      return listLeaveRequest;
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<StatisticModel> getStatictisUserLogin(
      {required DateTime timeStart, required DateTime timeEnd}) async {
    try {
      Map<String, dynamic> body = {
        "time_start_start": timeStart.toString(),
        "time_start_end": timeEnd.toString()
      };

      var response = await provider.get(ApiUrl.USER_STATISTIC, data: body);
      StatisticModel statistic = statisticFromJson(response.data["data"]);
      return statistic;
    } catch (e) {
      print("Error: " + e.toString());
    }
    return StatisticModel();
  }
}
