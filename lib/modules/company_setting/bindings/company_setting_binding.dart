import 'package:attendance_fast/modules/company_setting/controllers/company_setting_controller.dart';
import 'package:get/get.dart';

class CompanySettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CompanySettingController>(CompanySettingController());
  }
}
