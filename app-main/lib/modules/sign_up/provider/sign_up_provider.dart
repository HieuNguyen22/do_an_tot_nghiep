import 'dart:convert';

import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/modules/sign_up/models/fetch_company_model.dart';
import 'package:app_work_log/modules/user/models/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class SignUpProvider extends ServiceProvider {
  SignUpProvider() : super(provider: apiProvider);
  GetStorage boxStorage = GetStorage();

  /// GET company by ID
  Future<List<dynamic>> getCompanyById(String companyId) async {
    try {
      var response =
          await provider.get("${ApiUrl.GET_COMPANY_BY_CODE}/$companyId");

      print("----- RESPONSEeee: " + response.data.toString());

      var listCompany = response.data['data']
          .map((data) => FetchCompanyModel.fromJson(data))
          .toList();

      return listCompany;
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  /// POST sign up staff user
  Future<String> signUpUser(
      {required String firstName,
      required String lastName,
      required String email,
      required String employeeCode,
      required String companyId,
      required String password}) async {
    try {
      Map<String, dynamic> body = {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "employee_code": employeeCode,
        "company_id": companyId,
        "password": password,
      };
      var response =
          await provider.post(ApiUrl.REGISTER_STAFF_USER, data: body);

      print("----- RESPONSEeee: " + response.data.toString());

      if (response.statusCode != 201) {
        return "";
      }

      return response.data["data"]["token"];
    } catch (e) {
      print(e.toString());
    }
    return "";
  }
}
