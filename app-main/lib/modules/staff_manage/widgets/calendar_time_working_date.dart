import 'package:app_work_log/common/utils/dialog.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/staff_manage/controllers/workingh_statistics_staff_controller.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTimeWorkingDate extends GetView<WorkingHoursStatisticsStaffController> {
  const CalendarTimeWorkingDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2023, 01, 01),
          lastDay: DateTime.utc(2023, 12, 31),
          focusedDay: DateTime.now(),
          headerVisible: true,
          onPageChanged: (itemHeader) {
            controller.monthHeader.value = itemHeader.month;
            controller.yearHeader.value = itemHeader.year;
            controller.getSumTimeWorking();
            controller.getStatisticUserbyDate(DateTime(controller.yearHeader.value, controller.monthHeader.value, 1).toString(), DateTime(controller.yearHeader.value, controller.monthHeader.value + 1, 1).toString());
          },
          calendarBuilders:
              CalendarBuilders(defaultBuilder: (context, date, _) {
            String checkDate = DateFormat('yyyy-MM-dd').format(date);
            return Container(
              margin: EdgeInsets.all(4),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primaryText
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        controller.sumTime[checkDate] ?? '',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColor.primaryBlue,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }, todayBuilder: (context, date, _) {
            return Column(
              children: [
                Container(
                    margin: EdgeInsets.all(Numeral.WIDTH_SCREEN * 0.0125),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primaryBlue
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      DateFormat('d').format(date),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),
                    ),
                  ),
                  
              ],
            );
          }),
        )
      ],
    );
  }
}