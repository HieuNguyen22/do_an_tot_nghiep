import 'package:attendance_fast/common/api/api_base.dart';
import 'package:attendance_fast/common/api/api_url.dart';
import 'package:attendance_fast/common/utils/dialog.dart';
import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/modules/home/models/attendance_model.dart';
import 'package:attendance_fast/modules/home/models/statistic_model.dart';
import 'package:attendance_fast/modules/home/models/shift_model.dart';
import 'package:attendance_fast/modules/home/models/user_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class HomeProvider extends ServiceProvider {
  HomeProvider() : super(provider: apiProvider);
  GetStorage boxStorage = GetStorage();

  /// Get user infor
  Future<UserModel> getUserInfo() async {
    try {
      var response = await provider.get(ApiUrl.GET_USER_INFO);

      return UserModel.fromJson(response.data["data"]);
    } catch (e) {
      print(e);
    }
    return UserModel();
  }

  /// GET shift
  Future<List<dynamic>> getListShift() async {
    try {
      var response = await provider.get(ApiUrl.SHIFT_OF_COMPANY);

      var listShift = response.data['data']
          .map((data) => ShiftModel.fromJson(data))
          .toList();

      return listShift;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  /// Get Last Check In
  Future<AttendanceModel> getLastCheckIn() async {
    try {
      var response = await provider.get(ApiUrl.GET_LAST_CHECKIN);

      return AttendanceModel.fromJson(response.data["data"]);
    } catch (e) {
      print(e);
    }
    return AttendanceModel();
  }

  /// Check In
  Future<bool> checkIn(int shiftId, double latitudeCheckin, double longitudeCheckin, int typeWork) async {
    try {
      Map<String, dynamic> body = {
        "shift_id": shiftId,
        "latitude_checkin": latitudeCheckin,
        "longitude_checkin": longitudeCheckin,
        "type_work": typeWork
      };

      showLoading();
      var response = await provider.post(ApiUrl.CHECKIN, data: body);
      closeLoading();

      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      closeLoading();
    }
    return false;
  }

  /// Check Out
  Future<bool> checkOut(double latitudeCheckout, double longitudeCheckout) async {
    try {
      Map<String, dynamic> body = {
        "latitude_checkout": latitudeCheckout,
        "longitude_checkout": longitudeCheckout
      };
      showLoading();
      var response = await provider.put(ApiUrl.CHECKOUT, data: body);
      closeLoading();

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      closeLoading();
    }
    return false;
  }

  Future<StatisticModel> getStatictisUserLogin() async {
    try {
      var response = await provider.get(ApiUrl.USER_STATISTIC);
      StatisticModel statistic = statisticFromJson(response.data["data"]);
      return statistic;
    } catch (e) {
      print("Error: " + e.toString());
    }
    return StatisticModel();
  }

  Future<bool> checkOutLate(
      {required int managerId,
      required DateTime timeLeave,
      required String reason, 
      required double latitudeCheckout, 
      required double longitudeCheckout}) async {
    try {
      var body = {
        "to_approve_id": managerId,
        "duration": DateFormat("yyyy-MM-dd hh:mm:ss").format(timeLeave),
        "reason": reason,
        "latitude_checkout": latitudeCheckout,
        "longitude_checkout": longitudeCheckout
      };
      var response = await provider.put(ApiUrl.CHECK_OUT_LATE, data: body);

      if (response.statusCode == Numeral.STATUS_CODE_API_SUCCESS) {
        return true;
      }

      return false;
    } catch (e) {
      print("Error: " + e.toString());
      closeLoading();
    }
    return false;
  }
}
