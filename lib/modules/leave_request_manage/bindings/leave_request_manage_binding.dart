import 'package:attendance_fast/modules/leave_request_manage/controllers/leave_request_manage_controller.dart';
import 'package:get/get.dart';

class LeaveRequestManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LeaveRequestManageController>(LeaveRequestManageController());
  }
}
