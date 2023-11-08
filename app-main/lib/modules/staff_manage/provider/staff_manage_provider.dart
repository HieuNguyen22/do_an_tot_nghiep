import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/modules/staff_manage/models/staff.dart';
import 'package:dio/dio.dart';


class StaffManageProvider extends ServiceProvider {
  StaffManageProvider() : super(provider: apiProvider);

  Future<List<StaffManage>> getListStaffoffCompanyUserLogin() async {
    try {
      Response response = await provider.get(
          ApiUrl.STAFF_OF_COMPANY);
      List<StaffManage> attendances =
          staffManageFromJson(response.data["data"]);
      return attendances;
    } catch (e) {
      print(e.toString());
    }
    return <StaffManage>[];
  }
}
