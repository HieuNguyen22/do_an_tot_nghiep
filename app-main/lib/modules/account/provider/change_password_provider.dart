import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/common/utils/numeral.dart';

class ChangePasswordProvider extends ServiceProvider {
  ChangePasswordProvider() : super(provider: apiProvider);

  // Change password
  Future<bool> changePassword(
      {required String password,
      required String newPassword,
      required String confirmPassword}) async {
    try {
      Map<String, dynamic> body = {
        "currentPassword": password,
        "password": newPassword,
        "newConfirmPassword": confirmPassword,
      };

      var response = await provider.put(ApiUrl.UPDATE_PASSWORD, data: body);

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
