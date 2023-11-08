import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/department_manage/model/department_manager.dart';
import 'package:app_work_log/modules/department_manage/model/employee_company.dart';
import 'package:app_work_log/modules/department_manage/model/manager_company.dart';
import 'package:dio/dio.dart';

class DepartmentManageProvider extends ServiceProvider {
  DepartmentManageProvider() : super(provider: apiProvider);

  Future<List<DepartmentManage>> getListDepartmentofCompanyUserLogin(
      String companyId) async {
    try {
      Response response =
          await provider.get("${ApiUrl.DEPARTMENT_OF_COMPANY}/$companyId");
      List<DepartmentManage> departments =
          departmentManageFromJson(response.data["data"]);
      return departments;
    } catch (e) {
      print(e.toString());
    }
    return <DepartmentManage>[];
  }

  Future<List<ManagerCompany>> getListManagerofCompanyUserLogin() async {
    try {
      Response response = await provider.get(ApiUrl.MANAGER_OF_COMPANY);
      List<ManagerCompany> managers =
          managerCompanyFromJson(response.data["data"]);
      return managers;
    } catch (e) {
      print(e.toString());
    }
    return <ManagerCompany>[];
  }

  Future<List<EmployeeCompany>> getListEmployeeCompanyUserLogin() async {
    try {
      Response response = await provider.get(ApiUrl.COMPANY_EMPLOYEE);
      List<EmployeeCompany> managers =
          employeeCompanyFromJson(response.data["data"]);
      return managers;
    } catch (e) {
      print(e.toString());
    }
    return <EmployeeCompany>[];
  }

  Future<bool> addDepartment(String nameDepartment, int idCompany,
      int idManager, int statusCode) async {
    try {
      Response response = await provider.post(ApiUrl.POST_DEPARTMENT_COMPANY,
          data: idManager != Numeral.CODE_NOT_MANAGER
              ? {
                  "name": nameDepartment,
                  "company_id": idCompany,
                  "manager_id": idManager,
                  "status_code": statusCode
                }
              : {
                  "name": nameDepartment,
                  "company_id": idCompany,
                  "status_code": statusCode
                });

      return response.data["data"] != null;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> updateDepartment(
      int id, String name, int companyId, int managerId) async {
    try {
      Response response = await provider.put(
          "${ApiUrl.PUT_DEPARTMENT_COMPANY}/$id",
          data: managerId != Numeral.CODE_NOT_MANAGER
              ? {"name": name, "company_id": companyId, "manager_id": managerId}
              : {"name": name, "company_id": companyId});
      return response.data["data"] != null;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteDepartment(int id) async {
    try {
      var response =
          await provider.delete("${ApiUrl.DELETE_DEPARTMENT_COMPANY}/$id");
      return response.data["data"] != null;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
