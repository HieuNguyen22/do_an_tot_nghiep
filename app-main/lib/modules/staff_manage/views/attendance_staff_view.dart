import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/staff_manage/controllers/attendance_staff_controller.dart';
import 'package:app_work_log/modules/staff_manage/widgets/item_attendance_staff.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AttendanceStaffView extends GetView<AttendanceStaffController> {
  const AttendanceStaffView({Key? key}) : super(key: key);

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
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: Numeral.WIDTH_SCREEN * 0.025),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Container(
                              margin: EdgeInsets.only(top: Get.height * 0.0125),
                              child: BaseText(
                                text: controller.staff.value.firstName ==
                                            null ||
                                        controller.staff.value.lastName == null
                                    ? ""
                                    : "${controller.staff.value.firstName!} ${controller.staff.value.lastName!}",
                                isTile: true,
                                size: 18,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.005,
                          ),
                          // BaseText(
                          //   text: "Product Manager",
                          //   size: 16,
                          // ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
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
              Container(
                height: Get.height * 0.06,
                width: Numeral.WIDTH_SCREEN,
                decoration: BoxDecoration(
                  color: AppColor.colorBackgroundTitleTable,
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    left: Numeral.WIDTH_SCREEN * 0.025,
                    right: Numeral.WIDTH_SCREEN * 0.025,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                    ],
                  ),
                ),
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
                child: Row(children: [
                  SizedBox(
                    height: Get.height * 0.06,
                    width: Numeral.WIDTH_SCREEN * 0.2,
                    child: Center(
                      child: BaseText(
                        text: "date".tr,
                        isTile: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                    width: Numeral.WIDTH_SCREEN * 0.25,
                    child: Center(
                      child: BaseText(
                        text: "checkin".tr,
                        isTile: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                    width: Numeral.WIDTH_SCREEN * 0.2,
                    child: Center(
                      child: BaseText(
                        text: "checkout".tr,
                        isTile: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.06,
                    width: Numeral.WIDTH_SCREEN * 0.35,
                    child: Center(
                      child: BaseText(
                        text: "workingH".tr,
                        isTile: true,
                      ),
                    ),
                  ),
                ]),
              ),
              Obx(
                () => Expanded(
                  child: (controller.listAttendanceFromUserId.length == 1 &&
                          controller.listAttendanceFromUserId[0].id == -1)
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColor.primaryPurple),
                          ),
                        )
                      : ListView.builder(
                    itemCount: controller.listAttendanceFromUserId.length,
                    itemBuilder: (context, index) {
                      return ItemAttendanceStaff(
                        attendance: controller.listAttendanceFromUserId[index],
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
                  controller.getAttendanceFromUserId();
                } else {
                  if (DateFormat("yyyy/MM/dd")
                      .parse(controller.advancedTimeStart.value)
                      .isBefore(DateFormat("yyyy/MM/dd")
                          .parse(controller.advancedTimeEnd.value))) {
                    controller.checkFilterLeaveRequest.value = true;
                    controller.datesGetLeaveRequest.value =
                        "${controller.advancedTimeStart.value} - ${controller.advancedTimeEnd.value}";
                    Get.back();
                    controller.getAttendanceFromUserId();
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
