import 'package:app_work_log/common/api/api_base.dart';
import 'package:app_work_log/common/api/api_url.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/home/models/user_model.dart';

class DefaultCheckinProvider extends ServiceProvider {
  DefaultCheckinProvider() : super(provider: apiProvider);

  Future<UserModel> getUserInfo() async {
    try {
      var response = await provider.get(ApiUrl.GET_USER_INFO);
      return UserModel.fromJson(response.data["data"]);
    } catch (e) {
      print(e);
    }
    return UserModel();
  }

  Future<bool> updateDefaultCheckin(
      {required dynamic typeCheckin}) async {
    try {
      var response = await provider.put(ApiUrl.UPDATE_USER_INFO, data: {
        "type_login": typeCheckin
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
