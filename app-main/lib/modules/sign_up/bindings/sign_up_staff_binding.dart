import 'package:app_work_log/modules/sign_up/controllers/sign_up_staff_controller.dart';
import 'package:get/get.dart';


class SignUpStaffBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpStaffController>(() => SignUpStaffController());
  }
}
