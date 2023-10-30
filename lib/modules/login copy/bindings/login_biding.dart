import 'package:get/get.dart';
import 'package:attendance_fast/modules/login/controllers/login_controller.dart';
import 'package:attendance_fast/modules/login/controllers/register_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
