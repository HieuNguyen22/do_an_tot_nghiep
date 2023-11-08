import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/common/widgets/base_text_form_field.dart';
import 'package:app_work_log/modules/attendance_manage/controllers/attendance_manage_controller.dart';
import 'package:app_work_log/modules/attendance_manage/widgets/bottom_input_name_csv.dart';
import 'package:app_work_log/modules/attendance_manage/widgets/item_casual_leave.dart';
import 'package:app_work_log/modules/attendance_manage/widgets/item_checkin.dart';
import 'package:app_work_log/modules/attendance_manage/widgets/item_late.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceManageView extends GetView<AttendanceCheckInManageController> {
  const AttendanceManageView({Key? key}) : super(key: key);

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
                        text: "attendance_manage".tr,
                        isTile: true,
                        size: 24,
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          controller.textNameFileCsv.value.text = "";
                          Get.bottomSheet(BottomInputNameCsv());
                        },
                        child: SvgPicture.asset(
                            "assets/images/common/ic_export_csv.svg")),
                  ],
                ),
              ),
              Row(
                children: [
                  Obx(
                    () => Container(
                      width: Numeral.WIDTH_SCREEN * 0.425,
                      height: Get.height * 0.06,
                      margin: EdgeInsets.only(left: Numeral.WIDTH_SCREEN * 0.05),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: controller.selectCateAttendance.value.isEmpty
                                ? controller.itemCateAttendance[
                                    controller.indexSelect.value]
                                : controller.selectCateAttendance.value,
                            onChanged: (newValue) {
                              controller.selectCateAttendance.value = newValue!;
                              controller.indexSelect.value = controller
                                  .itemCateAttendance
                                  .indexWhere((element) => element == newValue);
                              controller.callApiChangeCateAttendance();
                            },
                            items: controller.itemCateAttendance
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: Numeral.WIDTH_SCREEN * 0.0125),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            BaseText(
                                              text: item,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(bottomSelectDate());
                    },
                    child: Container(
                      width: Numeral.WIDTH_SCREEN * 0.425,
                      height: Get.height * 0.06,
                      margin: EdgeInsets.only(left: Numeral.WIDTH_SCREEN * 0.05),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(children: [
                        SizedBox(
                          width: Numeral.WIDTH_SCREEN * 0.025,
                        ),
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: Numeral.WIDTH_SCREEN * 0.0125,
                        ),
                        Obx(
                          () => BaseText(
                            text: DateFormat('dd MMM, yyyy')
                                .format(controller.dayDisplay.value),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Numeral.WIDTH_SCREEN * 0.05,
              ),
              Obx(
                () => Expanded(
                  child: controller.indexSelect.value ==
                          Numeral.SELECT_LIST_CHECKIN
                      ? (controller.attendancesCheckIn.length == 1 &&
                              controller.attendancesCheckIn[0].id == -1)
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColor.primaryPurple),
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.attendancesCheckIn.length,
                              itemBuilder: (context, index) {
                                return ItemCheckIn(
                                  item: controller.attendancesCheckIn[index],
                                );
                              },
                            )
                      : controller.indexSelect.value == Numeral.SELECT_LIST_LATE
                          ? (controller.attendancesCheckInLate.length == 1 &&
                                  controller.attendancesCheckInLate[0].id == -1)
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColor.primaryPurple),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount:
                                      controller.attendancesCheckInLate.length,
                                  itemBuilder: (context, index) {
                                    return ItemLate(
                                      item: controller
                                          .attendancesCheckInLate[index],
                                    );
                                  },
                                )
                          : (controller.attendancesCasualLeave.length == 1 &&
                                  controller.attendancesCasualLeave[0].id == -1)
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColor.primaryPurple),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount:
                                      controller.attendancesCasualLeave.length,
                                  itemBuilder: (context, index) {
                                    return ItemCasualLeave(
                                      item: controller
                                          .attendancesCasualLeave[index],
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

  Widget bottomSelectDate() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        children: [
          Obx(
            () => TableCalendar(
              locale: "en_US",
              rowHeight: Get.height * 0.06,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) {
                return isSameDay(controller.selectDay.value, day);
              },
              focusedDay: controller.selectDay.value,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              onDaySelected: (selectedDay, focusedDay) {
                controller.selectDay.value = selectedDay;
              },
            ),
          ),
          SizedBox(
            height: Get.height * 0.025,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: BaseButton(
                  height: Get.height * 0.05,
                  width: Numeral.WIDTH_SCREEN * 0.35,
                  title: "Close",
                  textColor: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: Numeral.WIDTH_SCREEN * 0.1,
              ),
              InkWell(
                onTap: () async {
                  controller.dayDisplay.value = controller.selectDay.value;
                  controller.callApiChangeCateAttendance();
                  Get.back();
                },
                child: BaseButton(
                  height: Get.height * 0.05,
                  width: Numeral.WIDTH_SCREEN * 0.35,
                  title: "Ok",
                  textColor: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
