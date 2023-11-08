import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/staff_manage/models/attendance.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ItemAttendanceStaff extends StatelessWidget {

  final AttendanceModel attendance;
  String date = "11\nTue";
  String checkInTime = "--:--";
  String checkOutTime = "--:--";
  String workingHour = "--:--";

  List<String> weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  ItemAttendanceStaff({super.key, required this.attendance});

  @override
  Widget build(BuildContext context) {
    formatData();
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.0125),
      child: Row(
        children: [
          SizedBox(
            width: Numeral.WIDTH_SCREEN * 0.18,
            child: Container(
              height: Numeral.WIDTH_SCREEN * 0.15,
              width: Numeral.WIDTH_SCREEN * 0.15,
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  shape: BoxShape.circle),
              child: Center(
                child: BaseText(
                  text: date,
                  isTile: true,
                  size: 14,
                ),
              ),
            ),
          ),
          SizedBox(
            width: Numeral.WIDTH_SCREEN * 0.07,
            child: SvgPicture.asset("assets/images/common/ic_time_checkin.svg"),
          ),
          Container(
            width: Numeral.WIDTH_SCREEN * 0.175,
            child: BaseText(
              text: checkInTime,
              colorText: AppColor.colorTextTimeLate,
              size: 12,
            ),
          ),
          SizedBox(
            width: Numeral.WIDTH_SCREEN * 0.07,
            child:
                SvgPicture.asset("assets/images/common/ic_time_checkout.svg"),
          ),
          Container(
            width: Numeral.WIDTH_SCREEN * 0.175,
            child: BaseText(
              text: checkOutTime,
              colorText: AppColor.colorTextTimeNormal,
              size: 12,
            ),
          ),
          Expanded(
            child: Center(
              child: BaseText(
                text: workingHour,
                colorText: AppColor.colorTextWorkingHrs,
                size: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void formatData() {
    date =
        "${attendance.timeCheckin?.day}\n${weekdays[attendance.timeCheckin!.weekday - 1]}";

    if (attendance.timeCheckin != null) {
      checkInTime = DateFormat("HH:mm").format(attendance.timeCheckin!);
    }
    if (attendance.timeCheckout != null) {
      checkOutTime = DateFormat("HH:mm").format(attendance.timeCheckout!);
    }

    workingHour =
        calWorkingHour(attendance.timeCheckin, attendance.timeCheckout);
  }

  String calWorkingHour(DateTime? checkInTime, DateTime? checkOutTime) {
    var formatter = NumberFormat('00');

    if (checkInTime == null || checkOutTime == null) {
      return "--:--";
    } else {
      final Duration duration = checkOutTime.difference(checkInTime);
      int durationInMin = duration.inMinutes;
      return "${formatter.format(durationInMin ~/ 60)}h${formatter.format(durationInMin % 60)}";
    }
  }
}
