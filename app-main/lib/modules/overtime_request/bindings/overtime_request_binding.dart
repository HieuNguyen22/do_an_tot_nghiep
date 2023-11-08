import 'package:app_work_log/modules/overtime_request/controllers/overtime_request_controller.dart';
import 'package:get/get.dart';

class OvertimeRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OvertimeRequestController>(() => OvertimeRequestController());
  }
}
