import 'package:get/get.dart';
import 'package:app_work_log/modules/login/controllers/login_controller.dart';
import 'package:app_work_log/modules/login/controllers/register_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
