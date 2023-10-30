import 'package:attendance_fast/modules/account/controllers/default_shift_controller.dart';
import 'package:get/get.dart';

class DefaultShiftBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DefaultShiftController>(DefaultShiftController());
  }
}
