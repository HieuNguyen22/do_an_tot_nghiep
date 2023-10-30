import 'package:attendance_fast/modules/account/controllers/default_checkin_controller.dart';
import 'package:get/get.dart';

class DefaultCheckinBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DefaultCheckinController>(DefaultCheckinController());
  }
}
