import 'package:attendance_fast/modules/account/controllers/overtime_request_history_controller.dart';
import 'package:get/get.dart';

class OvertimeRequestHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OvertimeRequestHistoryController>(OvertimeRequestHistoryController());
  }
}
