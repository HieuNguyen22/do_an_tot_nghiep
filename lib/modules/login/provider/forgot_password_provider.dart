import 'package:attendance_fast/common/api/api_base.dart';
import 'package:attendance_fast/common/api/api_url.dart';
import 'package:dio/dio.dart';

class ForgotPasswordProvider extends ServiceProvider {
  ForgotPasswordProvider() : super(provider: apiProvider);

  /// Send overtime request
  Future<bool> sendRequestForgotPassword(String email) async {
    try {
      Map<String, dynamic> body = {
        "email": email,
      };
      Response response =
          await provider.post(ApiUrl.FORGOT_PASSWORD, data: body);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
    return false;
  }
}
