import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/account/models/shift_model.dart';
import 'package:app_work_log/modules/home/models/user_model.dart';
import 'package:dio/dio.dart';

class DefaultShiftProvider extends ServiceProvider {
  DefaultShiftProvider() : super(provider: apiProvider);

  Future<UserModel> getUserInfo() async {
    try {
      var response = await provider.get(ApiUrl.GET_USER_INFO);
      return UserModel.fromJson(response.data["data"]);
    } catch (e) {
      print(e);
    }
    return UserModel();
  }

  Future<List<ShiftManager>> getListShiftofCompanyUserLogin() async {
    try {
      Response response = await provider
          .get(ApiUrl.SHIFT_OF_COMPANY);
      List<ShiftManager> shifts = shiftManagerFromJson(response.data["data"]);
      return shifts;
    } catch (e) {
      print("Error: " + e.toString());
    }
    return <ShiftManager>[];
  }

  Future<bool> updateDefaultShift(
      {required dynamic shiftId}) async {
    try {
      var response = await provider.put(ApiUrl.UPDATE_USER_INFO, data: {
        "shift_id": shiftId
      });

      if (response.statusCode == Numeral.STATUS_CODE_API_SUCCESS) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
