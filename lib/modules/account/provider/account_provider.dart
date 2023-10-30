import 'package:attendance_fast/common/api/api_base.dart';
import 'package:attendance_fast/common/api/api_url.dart';
import 'package:attendance_fast/modules/home/models/user_model.dart';

class AccountProvider extends ServiceProvider {
  AccountProvider() : super(provider: apiProvider);

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
}
