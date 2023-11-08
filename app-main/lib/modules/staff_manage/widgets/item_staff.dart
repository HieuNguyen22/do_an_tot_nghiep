import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/staff_manage/models/staff.dart';
import 'package:app_work_log/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ItemStaff extends StatelessWidget {
  final StaffManage item;
  const ItemStaff({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            Get.toNamed(Routes.PROFILE_STAFF, arguments: item);
          },
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: Numeral.WIDTH_SCREEN * 0.025, top: Get.height * 0.0125),
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
                    text: item.firstName == null ? "N" : item.firstName![0],
                    isTile: true,
                    size: 18,
                  ),
                ),
              ),
              SizedBox(
                width: Numeral.WIDTH_SCREEN * 0.0125,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BaseText(
                        text: item.firstName == null || item.lastName == null ? "Null" : "${item.firstName} ${item.lastName}",
                        isTile: true,
                      ),
                      SizedBox(
                        width: Numeral.WIDTH_SCREEN * 0.0125,
                      ),
                      item.statusCode == Numeral.STATUS_CODE_ACTIVE ?
                      SvgPicture.asset(
                          "assets/images/manage/ic_staff_active.svg") : SvgPicture.asset(
                          "assets/images/manage/ic_staff_inactive.svg"),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.005,
                  ),
                  BaseText(
                    text: item.employeeCode == null ? "" : "#${item.employeeCode}",
                    colorText: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Get.toNamed(Routes.ATTENDANCE_STAFF, arguments: item);
          },
          child: Container(
            margin: EdgeInsets.only(right: Numeral.WIDTH_SCREEN * 0.05),
            child: SvgPicture.asset(
              "assets/images/manage/ic_late_statistics.svg",
              color: Colors.grey.withOpacity(0.4),
            ),
          ),
        ),
      ],
    );
  }
}
