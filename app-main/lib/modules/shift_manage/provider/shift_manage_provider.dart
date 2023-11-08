import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/modules/shift_manage/model/shift.dart';
import 'package:dio/dio.dart';

class ShiftManageProvider extends ServiceProvider {
  ShiftManageProvider() : super(provider: apiProvider);

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

  Future<bool> addShift(String companyId, String name, String timeStart,
      String timeEnd, int statusCode, int type) async {
    try {
      Response response = await provider.post(ApiUrl.POST_SHIFT_COMPANY, data: {
        "company_id": companyId,
        "name": name,
        "time_start": timeStart,
        "time_end": timeEnd,
        "status_code": statusCode,
        "type": type
      });

      return response.data["data"] != null;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateShift(int id, String name, String timeStart, String timeEnd) async {
    try {
      Response response = await provider.put("${ApiUrl.PUT_SHIFT_COMPANY}/$id",
          data: {
            "name": name,
            "time_start": timeStart,
            "time_end": timeEnd
          });
      print(response.statusCode);
      return response.data["data"] != null;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteShift(int id) async {
    try {
      var response = await provider.delete("${ApiUrl.DELETE_SHIFT_COMPANY}/$id");
      if (response.statusCode == 200) {
        print("Status code done: ");
      }
      return response.data["data"] != null;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
