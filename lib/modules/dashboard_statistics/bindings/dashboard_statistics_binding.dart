import 'package:attendance_fast/modules/dashboard_statistics/controllers/dashboard_statistics_controller.dart';
import 'package:get/get.dart';

class DashboardStatisticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DashboardStatisticsController>(DashboardStatisticsController());
  }
}
