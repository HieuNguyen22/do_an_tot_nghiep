import 'package:app_work_log/modules/shift_manage/controllers/shift_manage_controller.dart';
import 'package:get/get.dart';

class ShiftManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ShiftManageController>(ShiftManageController());
  }
}
