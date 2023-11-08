import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_appbar.dart';
import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_dialog.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/attendance/controllers/attendance_controller.dart';
import 'package:app_work_log/modules/attendance/widgets/ItemAttendanceWidget.dart';
import 'package:app_work_log/modules/staff_manage/widgets/item_attendance_staff.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceView extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: Numeral.WIDTH_SCREEN,
          height: Get.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/common/img_bg_1.png"),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.only(top: Get.height * 0.02),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                BaseAppBar(
                  title: "attendance".tr,
                  action: InkWell(
                    onTap: () {
                      getAdvancedSearch();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        right: Numeral.WIDTH_SCREEN * 0.025,
                      ),
                      child: SvgPicture.asset(
                          "assets/images/common/ic_filter.svg"),
                    ),
                  ),
                  actionLeft: Container(
                    width: Numeral.WIDTH_SCREEN * 0.025,
                  ),
                  hasBack: false,
                  titleStyle: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: AppColor.primaryText),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Expanded(
                    child: Container(
                  color: Colors.white,
                  child: getAttendanceTable(),
                ))
              ],
            ),
          )),
    );
  }

  getAttendanceTable() {
    return Column(
      children: [
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
              GestureDetector(
                  onTap: () => controller.getPreviousMonth(),
                  child: const Icon(Icons.chevron_left)),
              Expanded(
                child: GestureDetector(
                  onTap: () =>
                      getPickDateDialog(controller.chosenTime, "month"),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: AppColor.primaryBlue,
                      ),
                      SizedBox(
                        width: Numeral.WIDTH_SCREEN * 0.0125,
                      ),
                      Obx(
                        () => BaseText(
                          text: controller.displayedChosenTime.value,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () => controller.getNextMonth(),
                  child: const Icon(Icons.chevron_right)),
            ]),
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
              // height: Get.height * 0.06,
              width: Numeral.WIDTH_SCREEN * 0.2,
              child: Center(
                child: BaseText(
                  text: "date".tr,
                  isTile: true,
                ),
              ),
            ),
            SizedBox(
              // height: Get.height * 0.06,
              width: Numeral.WIDTH_SCREEN * 0.25,
              child: Center(
                child: BaseText(
                  text: "checkin".tr,
                  isTile: true,
                ),
              ),
            ),
            SizedBox(
              // height: Get.height * 0.06,
              width: Numeral.WIDTH_SCREEN * 0.2,
              child: Center(
                child: BaseText(
                  text: "checkout".tr,
                  isTile: true,
                ),
              ),
            ),
            SizedBox(
              // height: Get.height * 0.06,
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
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controller.fetchedListCheckIn.length,
              itemBuilder: (context, index) {
                return ItemAttendanceWidget(
                    attendance: controller.fetchedListCheckIn[index]);
              },
            ),
          ),
        ),
      ],
    );
  }

  getPickDateDialog(RxString typeDate, String type) {
    String tempDate = "";
    DateTime selectedDate;

    showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: Numeral.WIDTH_SCREEN * 0.7,
              height: Get.height * 0.4,
              decoration: const BoxDecoration(color: Colors.white),
              child: SfDateRangePicker(
                allowViewNavigation: false,
                view: (type == "day")
                    ? DateRangePickerView.month
                    : DateRangePickerView.year,
                monthViewSettings:
                    const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                  if (type == "day") {
                    selectedDate = dateRangePickerSelectionChangedArgs.value;
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
                child: const Text("OK"),
                onPressed: () {
                  typeDate.value = tempDate;
                  if (type == "month") {
                    controller.displayedChosenTime.value = typeDate.value;
                  }
                  // controller.callApiGetListCheckIn();
                  Get.back();
                },
              )
            ],
          );
        });
  }

  getTimePickerWidget(String label, RxString typeDate, String dayType) {
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
                            "begin".tr, controller.advancedTimeStart, "start"),
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
                            "end".tr, controller.advancedTimeEnd, "end"),
                      ]),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.updateDisplayedChosenTimeAdvanced();
                controller.callApiGetListCheckInAdvanced();
                Get.back();
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
