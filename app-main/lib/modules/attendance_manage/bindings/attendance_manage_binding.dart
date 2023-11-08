import 'package:app_work_log/modules/attendance_manage/controllers/attendance_manage_controller.dart';
import 'package:get/get.dart';

class AttendanceManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AttendanceCheckInManageController>(AttendanceCheckInManageController());
  }
}
