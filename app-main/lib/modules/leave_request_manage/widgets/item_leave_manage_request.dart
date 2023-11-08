import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/leave_request_manage/controllers/leave_request_manage_controller.dart';
import 'package:app_work_log/modules/leave_request_manage/models/leave_request_manage.dart';
import 'package:app_work_log/modules/leave_request_manage/widgets/confirm_leave_request_view.dart';
import 'package:app_work_log/modules/leave_request_manage/widgets/detail_leave_request_view.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:app_work_log/themes/style_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemLeaveRequest extends GetView<LeaveRequestManageController> {
  final LeaveRequestManage item;
  const ItemLeaveRequest({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (item.statusCode == Numeral.STATUS_CODE_PENDING) {
          controller.isConfirmLeaveRequest.value = false;
          controller.textReasonController.value.text = "";
          Get.dialog(ConfirmLeaveRequestView(item: item,),);
        } else {
          Get.dialog(DetailLeaveRequestView(item: item,),);
        }
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                        text: item.userInfo!.firstName == null
                            ? ""
                            : item.userInfo!.firstName![0],
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
                      SizedBox(
                        width: Numeral.WIDTH_SCREEN * 0.5,
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              style: styleTitle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                decoration: TextDecoration.none,
                                color: AppColor.colorTextGreyDark,
                              ),
                              text: item.userInfo!.firstName == null ||
                                      item.userInfo!.firstName == null
                                  ? ""
                                  : "${item.userInfo!.firstName} ${item.userInfo!.lastName!}"),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.005,
                      ),
                      BaseText(
                        text: "#${item.userInfo!.employeeCode!}",
                        colorText: Colors.grey,
                        size: 14,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: Numeral.WIDTH_SCREEN * 0.05),
                child: BaseButton(
                  height: Get.height * 0.05,
                  width: Numeral.WIDTH_SCREEN * 0.25,
                  title: controller.setTextfromStatusCode(item.statusCode!),
                  borderRadius: 20,
                  textColor: AppColor.primaryText,
                  fontWeight: FontWeight.w600,
                  colorBegin:
                      controller.setColorfromStatusCode(item.statusCode!),
                  colorEnd: controller.setColorfromStatusCode(item.statusCode!),
                ),
              ),
            ],
          ),
          Container(
            margin:
                EdgeInsets.only(top: Get.height * 0.005, left: Numeral.WIDTH_SCREEN * 0.1),
            child: Row(
              children: [
                Expanded(
                  child: BaseText(
                    text: "From: ${controller.formatDateTime(item.timeStart!)}",
                    colorText: AppColor.primaryBlue,
                    size: 13,
                  ),
                ),
                Expanded(
                  child: BaseText(
                    text: item.timeEnd == null
                        ? "--:--"
                        : "To: ${controller.formatDateTime(item.timeEnd!)}",
                    colorText: AppColor.primaryBlue,
                    size: 13,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
