import 'package:attendance_fast/modules/enroll_company/controllers/enroll_company_controller.dart';
import 'package:get/get.dart';


class EnrollCompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnrollCompanyController>(() => EnrollCompanyController());
  }
}
