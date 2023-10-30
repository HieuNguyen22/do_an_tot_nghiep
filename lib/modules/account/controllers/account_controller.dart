import 'package:attendance_fast/common/global.dart';
import 'package:attendance_fast/modules/account/provider/account_provider.dart';
import 'package:attendance_fast/modules/home/models/user_model.dart';
import 'package:attendance_fast/oauth2/service/auth_service.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  var selectLanguage = 0.obs;
  var userInfo = UserModel().obs;
  var userFullName = Global.userName.obs;

  var responseUserName;

  @override
  void onInit() {
    super.onInit();
    getLanguage();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    callApiUserProvider();
  }

  /// Get user infor
  void callApiUserProvider() async {
    var result = await AccountProvider().getUserInfo();
    userInfo.value = result;
    userFullName.value = "${userInfo.value.firstName} ${userInfo.value.lastName}";

    if (result.id != null) {
      Global.userId = result.id!;
    }

    if (result.companyId != null) {
      Global.companyId = result.companyId!;
    }

    if (result.firstName != null && result.lastName != null) {
      Global.userName = "${result.firstName} ${result.lastName}";
    }
  }

  getLanguage() async {
    switch (Get.find<AuthService>().languageApp) {
      case 1:
        selectLanguage.value = 1;
        break;
      case 2:
        selectLanguage.value = 2;
        break;
      case 3:
        selectLanguage.value = 3;
        break;
      default:
        selectLanguage.value = 2;
    }
  }
}
