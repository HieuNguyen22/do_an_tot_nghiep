import 'package:attendance_fast/modules/account/controllers/leave_request_history_controller.dart';
import 'package:get/get.dart';

class LeaveRequestHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LeaveRequestHistoryController>(LeaveRequestHistoryController());
  }
}
