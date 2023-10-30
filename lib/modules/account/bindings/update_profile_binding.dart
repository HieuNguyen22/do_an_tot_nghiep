import 'package:attendance_fast/modules/account/controllers/update_profile_controller.dart';
import 'package:get/get.dart';

class UpdateProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateProfileController>(() => UpdateProfileController());
  }
}
