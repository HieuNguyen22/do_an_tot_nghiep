import 'package:app_work_log/modules/staff_manage/controllers/workingh_statistics_staff_controller.dart';
import 'package:get/get.dart';

class WorkingHoursStatisticsStaffBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WorkingHoursStatisticsStaffController>(WorkingHoursStatisticsStaffController());
  }
}
