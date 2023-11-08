import 'package:app_work_log/modules/manage/controllers/manage_controller.dart';
import 'package:get/get.dart';

class ManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ManageController>(ManageController());
  }
}
