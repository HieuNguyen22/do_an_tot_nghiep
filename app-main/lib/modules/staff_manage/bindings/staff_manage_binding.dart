import 'package:app_work_log/modules/staff_manage/controllers/staff_manage_controller.dart';
import 'package:get/get.dart';

class StaffManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StaffManageController>(StaffManageController());
  }
}
