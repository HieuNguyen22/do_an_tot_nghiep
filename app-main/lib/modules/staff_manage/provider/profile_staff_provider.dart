import 'dart:convert';

import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/common/utils/dialog.dart';
import 'package:app_work_log/modules/staff_manage/models/department.dart';
import 'package:app_work_log/modules/staff_manage/models/staff.dart';
import 'package:dio/dio.dart';

class ProfileStaffProvider extends ServiceProvider {
  ProfileStaffProvider() : super(provider: apiProvider);

  Future<bool> updateWorkInfoStaff(String id, StaffManage staffManage) async {
    try {
      Response response = await provider.put("${ApiUrl.ADMIN_UPDATE_USER}/$id", data: staffManage.toJson());
      return response.data["data"] != null;
    } catch (e) {
      print("Error: " + e.toString());
      return false;
    }
  }

  Future<List<DepartmentManage>> getListDepartmentofCompanyUserLogin(String companyId) async {
    try {
      Response response = await provider.get("${ApiUrl.DEPARTMENT_OF_COMPANY}/$companyId");
      List<DepartmentManage> departments =
          departmentManageFromJson(response.data["data"]);
      return departments;
    } catch (e) {
      closeLoading();
      print(e.toString());
    }
    return <DepartmentManage>[];
  }
}
