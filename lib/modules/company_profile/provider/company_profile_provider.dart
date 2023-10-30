import 'package:attendance_fast/common/api/api_base.dart';
import 'package:attendance_fast/common/api/api_url.dart';
import 'package:attendance_fast/modules/company_profile/models/company.dart';
import 'package:dio/dio.dart';


class CompanyProfileProvider extends ServiceProvider {
  CompanyProfileProvider() : super(provider: apiProvider);

  Future<CompanyModel> getInfoCompanyUserLogin(
      String companyId) async {
    try {
      Response response = await provider
          .get("${ApiUrl.INFO_COMPANY_BY_CODE}/$companyId");
      CompanyModel companyModel = companyModelFromJson(response.data["data"]);
      return companyModel;
    } catch (e) {
      print("Error: " + e.toString());
    }
    return CompanyModel();
  }

  Future<bool> updateInfoCompany(String id, CompanyModel companyModel) async {
    try {
      Response response = await provider.put("${ApiUrl.UPDATE_INFO_COMPANY_BY_CODE}/$id", data: companyModel.toJson());
      return response.data["data"] != null;
    } catch (e) {
      print("Error: " + e.toString());
      return false;
    }
  }
}
