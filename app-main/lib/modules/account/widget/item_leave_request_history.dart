import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/account/models/leave_request_model.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ItemLeaveRequestHistory extends StatelessWidget {
  final LeaveRequestModel leaveRequest;
  const ItemLeaveRequestHistory({super.key, required this.leaveRequest});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: Get.height * 0.005, left: Numeral.WIDTH_SCREEN * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BaseText(
                        text: "from".tr,
                        colorText: AppColor.primaryBlue,
                        isTile: true,
                        size: 13,
                      ),
                      const SizedBox(width: 6),
                      BaseText(
                        text: DateFormat("yyyy-MM-dd hh:mm")
                            .format(leaveRequest.timeStart!),
                        colorText: AppColor.primaryBlue,
                        isTile: true,
                        size: 13,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      BaseText(
                        text: "to".tr,
                        colorText: AppColor.primaryBlue,
                        isTile: true,
                        size: 13,
                      ),
                      const SizedBox(width: 6),
                      BaseText(
                        text: DateFormat("yyyy-MM-dd hh:mm")
                            .format(leaveRequest.timeEnd!),
                        colorText: AppColor.primaryBlue,
                        isTile: true,
                        size: 13,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            getStatusWidget(type: leaveRequest.statusCode ?? 1)
          ],
        ),
        const Divider(),
      ],
    );
  }

  getStatusWidget({required int type}) {
    String label = "pending".tr;
    Color color = AppColor.colorButtonPending;

    if (type == Numeral.STATUS_CODE_APPROVED) {
      label = "approved".tr;
      color = AppColor.colorButtonApproved;
    } else if (type == Numeral.STATUS_CODE_REJECT) {
      label = "rejected".tr;
      color = AppColor.colorButtonReject;
    }

    return Container(
      margin: EdgeInsets.only(right: Numeral.WIDTH_SCREEN * 0.05),
      child: InkWell(
        onTap: () {},
        child: BaseButton(
          height: Get.height * 0.05,
          width: Numeral.WIDTH_SCREEN * 0.25,
          title: label,
          borderRadius: 20,
          textColor: AppColor.primaryText,
          fontWeight: FontWeight.w500,
          colorBegin: color,
          colorEnd: color,
        ),
      ),
    );
  }
}
