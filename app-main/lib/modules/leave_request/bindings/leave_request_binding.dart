import 'package:app_work_log/modules/leave_request/controllers/leave_request_controller.dart';
import 'package:get/get.dart';

class LeaveRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaveRequestController>(() => LeaveRequestController());
  }
}
