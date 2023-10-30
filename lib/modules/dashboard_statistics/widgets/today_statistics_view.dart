import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_card_statistics.dart';
import 'package:attendance_fast/modules/dashboard_statistics/controllers/dashboard_statistics_controller.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TodayStatisticsView extends GetView<DashboardStatisticsController> {
  const TodayStatisticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.companyStatisticWeek.value.hoursOff == null)
          ? Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColor.primaryPurple),
              ),
            )
          : Column(
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
                        value: controller.companyStatisticDay.value.checkins
                            .toString(),
                        sizeValue: 32,
                        beginColor: AppColor.colorStatisticsCheckinToday,
                        endColor: AppColor.colorStatisticsCheckinToday
                            .withOpacity(0.5),
                        icon: SvgPicture.asset(
                            "assets/images/manage/ic_checkin_statistics.svg"),
                      ),
                      BaseCardStatistics(
                        text: "late".tr,
                        value: controller.companyStatisticDay.value.lateArrivals
                            .toString(),
                        sizeValue: 32,
                        beginColor: AppColor.colorStatisticsLateToday,
                        endColor:
                            AppColor.colorStatisticsLateToday.withOpacity(0.5),
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
                        value: controller.companyStatisticDay.value.leaveRequest
                            .toString(),
                        sizeValue: 32,
                        beginColor: AppColor.colorStatisticsAbsentToday,
                        endColor: AppColor.colorStatisticsAbsentToday
                            .withOpacity(0.5),
                        icon: SvgPicture.asset(
                            "assets/images/manage/ic_absent_statistics.svg"),
                      ),
                      BaseCardStatistics(
                        text: "overtime".tr,
                        value: controller
                            .companyStatisticDay.value.overtimeRequest
                            .toString(),
                        sizeValue: 32,
                        beginColor: AppColor.colorStatisticsCasualLeaveToday,
                        endColor: AppColor.colorStatisticsCasualLeaveToday
                            .withOpacity(0.5),
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
