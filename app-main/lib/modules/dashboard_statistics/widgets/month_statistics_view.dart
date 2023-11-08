import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_card_statistics.dart';
import 'package:app_work_log/modules/dashboard_statistics/controllers/dashboard_statistics_controller.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MonthStatisticsView extends GetView<DashboardStatisticsController> {
  const MonthStatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: Get.height * 0.0125,
                left: Numeral.WIDTH_SCREEN * 0.05,
                right: Numeral.WIDTH_SCREEN * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseCardStatistics(
                  width: Numeral.WIDTH_SCREEN * 0.425,
                  text: "check_in".tr,
                  value: controller.companyStatisticMonth.value.checkins.toString(),
                  sizeValue: 32,
                  beginColor: AppColor.colorStatisticsCheckinMonth,
                  endColor: AppColor.colorStatisticsCheckinMonth.withOpacity(0.5),
                  icon: SvgPicture.asset(
                      "assets/images/manage/ic_checkin_statistics.svg"),
                ),
                BaseCardStatistics(
                  text: "late".tr,
                  value: controller.companyStatisticMonth.value.lateArrivals.toString(),
                  sizeValue: 32,
                  beginColor: AppColor.colorStatisticsLateMonth,
                  endColor: AppColor.colorStatisticsLateMonth.withOpacity(0.5),
                  icon: SvgPicture.asset(
                      "assets/images/manage/ic_late_statistics.svg"),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: Get.height * 0.0125,
                left: Numeral.WIDTH_SCREEN * 0.05,
                right: Numeral.WIDTH_SCREEN * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseCardStatistics(
                  width: Numeral.WIDTH_SCREEN * 0.425,
                  text: "casual_leave".tr,
                  value: controller.companyStatisticMonth.value.leaveRequest.toString(),
                  sizeValue: 32,
                  beginColor: AppColor.colorStatisticsAbsentMonth,
                  endColor: AppColor.colorStatisticsAbsentMonth.withOpacity(0.5),
                  icon: SvgPicture.asset(
                      "assets/images/manage/ic_absent_statistics.svg"),
                ),
                BaseCardStatistics(
                  text: "overtime".tr,
                  value: controller.companyStatisticMonth.value.overtimeRequest.toString(),
                  sizeValue: 32,
                  beginColor: AppColor.colorStatisticsCasualLeaveMonth,
                  endColor: AppColor.colorStatisticsCasualLeaveMonth.withOpacity(0.5),
                  icon: SvgPicture.asset(
                      "assets/images/manage/ic_casual_leave_statistics.svg"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}