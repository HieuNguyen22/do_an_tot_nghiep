import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/attendance_manage/controllers/attendance_manage_controller.dart';
import 'package:app_work_log/modules/attendance_manage/models/attendance_checkin_manage.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ItemLate extends GetView<AttendanceCheckInManageController> {
  final AttendanceCheckInManage item;
  const ItemLate({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: Numeral.WIDTH_SCREEN * 0.025, top: Get.height * 0.0125, right: Numeral.WIDTH_SCREEN * 0.0125),
          height: Numeral.WIDTH_SCREEN * 0.13,
          width: Numeral.WIDTH_SCREEN * 0.13,
          decoration: BoxDecoration(
            color: Colors.white,
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
              shape: BoxShape.circle),
          child: Center(
            child: BaseText(
              text: item.userInfo!.firstName == null ? "" : item.userInfo!.firstName![0],
              isTile: true,
              size: 18,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: item.userInfo!.firstName == null ||  item.userInfo!.lastName == null ? "" : "${item.userInfo!.firstName} ${item.userInfo!.lastName!}",
              isTile: true,
            ),
            SizedBox(height: Get.height * 0.005,),
            BaseText(
              text: "#${item.userId}",
              colorText: Colors.grey,
            ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        SvgPicture.asset("assets/images/common/ic_time_checkin.svg", color: AppColor.colorTextTimeLate,),
        BaseText(
          text: controller.filterHoursfromDateTime(item.timeCheckin!),
          colorText: AppColor.colorTextTimeLate,
        ),
        SizedBox(
          width: Numeral.WIDTH_SCREEN * 0.05,
        ),
      ],
    );
  }
}
