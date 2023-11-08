import 'package:app_work_log/modules/department_manage/controllers/department_manage_controller.dart';
import 'package:get/get.dart';

class DepartmentManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DepartmentManageController>(DepartmentManageController());
  }
}
