import 'package:app_work_log/modules/overtime_request_manage/controllers/overtime_request_manage_controller.dart';
import 'package:get/get.dart';

class OverTimeRequestManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OverTimeRequestManageController>(OverTimeRequestManageController());
  }
}
