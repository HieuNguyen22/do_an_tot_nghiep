import 'package:app_work_log/modules/staff_manage/controllers/profile_staff_controller.dart';
import 'package:get/get.dart';

class ProfileStaffBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileStaffController>(ProfileStaffController());
  }
}
