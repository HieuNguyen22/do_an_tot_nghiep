import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/languages/language_service.dart';
import 'package:attendance_fast/modules/home/controllers/home_controller.dart';
import 'package:attendance_fast/modules/manage/controllers/manage_controller.dart';
import 'package:attendance_fast/oauth2/service/auth_service.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  var selectLanguage = 0.obs;
  final authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    switch (authService.languageApp) {
      case 1:
        selectLanguage.value = Numeral.LANGUAGE_EN;
        break;
      case 2:
        selectLanguage.value = Numeral.LANGUAGE_VN;
        break;
      case 3:
        selectLanguage.value = Numeral.LANGUAGE_JP;
        break;
      default:
        selectLanguage.value = Numeral.LANGUAGE_EN;
        break;
    }
  }

  setSelectedLanguage(int value) {
    selectLanguage.value = value;
  }

  saveLanguage(){
    Get.find<AuthService>().setLanguageServiceApp(selectLanguage.value);
     switch (Get.find<AuthService>().languageApp) {
      case 1:
        LanguageService.changeLocale("en");
        break;
      case 2:
        LanguageService.changeLocale("vi");
        break;
      case 3:
        LanguageService.changeLocale("jp");
        break;
      default:
        LanguageService.changeLocale("en");
        break;
    }
    refreshLanguage();
  }

  refreshLanguage(){
    Get.find<ManageController>().getManage();
    Get.find<HomeController>().getDateNow();
  }
}
