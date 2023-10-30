import 'package:attendance_fast/modules/company_profile/controllers/company_profile_controller.dart';
import 'package:get/get.dart';

class CompanyProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CompanyProfileController>(CompanyProfileController());
  }
}
