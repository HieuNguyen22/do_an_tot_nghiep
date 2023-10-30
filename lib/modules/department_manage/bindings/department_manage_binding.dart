import 'package:attendance_fast/modules/department_manage/controllers/department_manage_controller.dart';
import 'package:get/get.dart';

class DepartmentManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DepartmentManageController>(DepartmentManageController());
  }
}
