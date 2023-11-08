import 'package:app_work_log/modules/staff_manage/controllers/attendance_staff_controller.dart';
import 'package:get/get.dart';

class AttendanceStaffBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AttendanceStaffController>(AttendanceStaffController());
  }
}
