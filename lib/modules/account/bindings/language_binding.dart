import 'package:attendance_fast/modules/account/controllers/language_controller.dart';
import 'package:get/get.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LanguageController>(LanguageController());
  }
}
