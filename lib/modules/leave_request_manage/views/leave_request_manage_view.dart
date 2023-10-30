import 'dart:math';

import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_button.dart';
import 'package:attendance_fast/common/widgets/base_card_statistics.dart';
import 'package:attendance_fast/common/widgets/base_text.dart';
import 'package:attendance_fast/modules/leave_request_manage/controllers/leave_request_manage_controller.dart';
import 'package:attendance_fast/modules/leave_request_manage/widgets/item_leave_manage_request.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class LeaveRequestManageView extends GetView<LeaveRequestManageController> {
  const LeaveRequestManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: Get.height,
        width: Numeral.WIDTH_SCREEN,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/common/img_bg_2.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.chevron_left,
                          size: 24,
                        )),
                    Expanded(
                      child: BaseText(
                        text: "leave_requests".tr,
                        isTile: true,
                        size: 24,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getAdvancedSearch();
                      },
                      child: SvgPicture.asset(
                          "assets/images/common/ic_filter.svg"),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.0125,
              ),
              Container(
                height: Get.height * 0.06,
                width: Numeral.WIDTH_SCREEN,
                margin: EdgeInsets.only(
                  top: Get.height * 0.0125,
                ),
                decoration: BoxDecoration(
                  color: AppColor.colorBackgroundTitleTable,
                ),
                child: Container(
                  margin: EdgeInsets.only(
                      left: Numeral.WIDTH_SCREEN * 0.05, right: Numeral.WIDTH_SCREEN * 0.05),
                  child: Row(children: [
                    InkWell(
                      onTap: () {
                        controller.backDateLeaveRequest();
                      },
                      child: const Icon(Icons.chevron_left),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => BaseText(
                              isTile: true,
                              text: controller.checkFilterLeaveRequest.value
                                  ? controller.datesGetLeaveRequest.value
                                  : DateFormat("yyyy/MM/dd").format(
                                      controller.dateGetLeaveRequest.value),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.nextDateLeaveRequest();
                      },
                      child: const Icon(Icons.chevron_right),
                    ),
                  ]),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Numeral.WIDTH_SCREEN * 0.025),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => BaseCardStatistics(
                        width: Numeral.WIDTH_SCREEN * 0.4,
                        height: Get.height * 0.1,
                        text: "total_request".tr,
                        sizeText: 18,
                        value: controller.listLeaveRequest.length == 1 &&
                                    controller.listLeaveRequest[0].id == -1 ||
                                controller.companyStatistic.value.hoursOff ==
                                    null
                            ? "0"
                            : controller.listLeaveRequest.length.toString(),
                        sizeValue: 32,
                        icon: SizedBox(
                          height: Numeral.WIDTH_SCREEN * 0.08,
                          width: Numeral.WIDTH_SCREEN * 0.08,
                          child: SvgPicture.asset(
                            "assets/images/manage/ic_statistics_checkin.svg",
                            color: Colors.white,
                          ),
                        ),
                        beginColor: AppColor.primaryGreen,
                        endColor: AppColor.primaryGreen.withOpacity(0.6),
                      ),
                    ),
                    SizedBox(
                      width: Numeral.WIDTH_SCREEN * 0.05,
                    ),
                    Obx(
                      () => BaseCardStatistics(
                        width: Numeral.WIDTH_SCREEN * 0.4,
                        height: Get.height * 0.1,
                        text: "total_hours".tr,
                        sizeText: 18,
                        value:
                            controller.companyStatistic.value.hoursOff == null
                                ? "0.00"
                                : controller.companyStatistic.value.hoursOff!
                                    .toStringAsFixed(2),
                        sizeValue: 32,
                        icon: SizedBox(
                          height: Numeral.WIDTH_SCREEN * 0.08,
                          width: Numeral.WIDTH_SCREEN * 0.08,
                          child: SvgPicture.asset(
                            "assets/images/manage/ic_late_statistics.svg",
                          ),
                        ),
                        beginColor: AppColor.primaryOrange,
                        endColor: AppColor.primaryOrange.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Obx(
                () => Expanded(
                  child: (controller.listLeaveRequest.length == 1 &&
                              controller.listLeaveRequest[0].id == -1 ||
                          controller.companyStatistic.value.hoursOff == null)
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColor.primaryPurple),
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.listLeaveRequest.length,
                          itemBuilder: (context, index) {
                            return ItemLeaveRequest(
                              item: controller.listLeaveRequest[index],
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getPickDateDialog(RxString typeDate, String type) {
    String tempDate = DateFormat('yyyy/MM/dd').format(DateTime.now());

    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: Numeral.WIDTH_SCREEN * 0.7,
              height: Get.height * 0.4,
              decoration: BoxDecoration(color: Colors.white),
              child: SfDateRangePicker(
                allowViewNavigation: false,
                view: (type == "day")
                    ? DateRangePickerView.month
                    : DateRangePickerView.year,
                monthViewSettings:
                    DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                  if (type == "day") {
                    tempDate = DateFormat('yyyy/MM/dd')
                        .format(dateRangePickerSelectionChangedArgs.value)
                        .toString();
                  } else {
                    tempDate = DateFormat("MMMM yyyy")
                        .format(dateRangePickerSelectionChangedArgs.value)
                        .toString();
                  }
                },
              ),
            ),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  typeDate.value = tempDate;
                  Get.back();
                },
              )
            ],
          );
        });
  }

  getTimePickerWidget(String label, RxString typeDate) {
    return GestureDetector(
      onTap: () {
        getPickDateDialog(typeDate, "day");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(
                    text: label,
                    size: 14,
                    isTile: false,
                    colorText: AppColor.primaryGrey,
                  ),
                  const SizedBox(height: 4),
                  Obx(
                    () => BaseText(
                      text: typeDate.value,
                      size: 16,
                      colorText: AppColor.primaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 18),
              Icon(
                Icons.calendar_month,
                size: 22,
                color: AppColor.primaryText,
              ),
            ],
          )
        ],
      ),
    );
  }

  void getAdvancedSearch() {
    Get.bottomSheet(
      useRootNavigator: true,
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
        height: Get.height * 0.25,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                BaseText(
                  text: "choose_dates".tr,
                  colorText: AppColor.primaryText,
                  size: 19,
                  isTile: true,
                ),
              ],
            ),
            Container(
              height: Get.height * 0.07,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.primaryText)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getTimePickerWidget(
                            "begin".tr, controller.advancedTimeStart),
                      ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: VerticalDivider(
                      color: AppColor.primaryText,
                      thickness: 0.7,
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        getTimePickerWidget(
                            "end".tr, controller.advancedTimeEnd),
                      ]),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (controller.advancedTimeStart.value ==
                    controller.advancedTimeEnd.value) {
                  controller.checkFilterLeaveRequest.value = false;
                  controller.dateGetLeaveRequest.value =
                      DateFormat("yyyy/MM/dd")
                          .parse(controller.advancedTimeStart.value);
                  Get.back();
                  controller.getListLeaveRequest();
                } else {
                  if (DateFormat("yyyy/MM/dd")
                      .parse(controller.advancedTimeStart.value)
                      .isBefore(DateFormat("yyyy/MM/dd")
                          .parse(controller.advancedTimeEnd.value))) {
                    controller.checkFilterLeaveRequest.value = true;
                    controller.datesGetLeaveRequest.value =
                        "${controller.advancedTimeStart.value} - ${controller.advancedTimeEnd.value}";
                    Get.back();
                    controller.getListLeaveRequest();
                  } else {
                    Get.snackbar("noti".tr, "date_end_before_date_begin".tr);
                  }
                }
              },
              child: BaseButton(
                height: Get.height * 0.05,
                width: Numeral.WIDTH_SCREEN * 0.7,
                title: "search".tr,
                textColor: Colors.white,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
