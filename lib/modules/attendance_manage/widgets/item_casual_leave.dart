import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_text.dart';
import 'package:attendance_fast/modules/attendance_manage/models/attendance_casual_leave_manage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemCasualLeave extends StatelessWidget {
  final AttendanceCasualLeave  item;
  const ItemCasualLeave({super.key, required this.item});

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
              text: item.userInfo!.firstName![0],
              isTile: true,
              size: 18,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: "${item.userInfo!.firstName!} ${item.userInfo!.lastName!}",
              isTile: true,
            ),
            SizedBox(height: Get.height * 0.005,),
            BaseText(
              text: "#${item.userInfo!.employeeCode}",
              colorText: Colors.grey,
            ),
          ],
        ),
        Expanded(
          child: Container(),
        ),
        Container(
          height: Numeral.WIDTH_SCREEN * 0.1,
          width: Numeral.WIDTH_SCREEN * 0.25,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(20)),
          child: const Center(
            child: BaseText(
              text: "Casual Leave",
              colorText: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: Numeral.WIDTH_SCREEN * 0.05,
        ),
      ],
    );
  }
}
