import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_text.dart';
import 'package:attendance_fast/modules/leave_request_manage/controllers/leave_request_manage_controller.dart';
import 'package:attendance_fast/modules/leave_request_manage/models/leave_request_manage.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmLeaveRequestView extends GetView<LeaveRequestManageController> {
  final LeaveRequestManage item;
  const ConfirmLeaveRequestView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: Get.height * 0.0125),
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
                            BaseText(
                              text: item.userInfo!.firstName == null ||
                                      item.userInfo!.firstName == null
                                  ? ""
                                  : "${item.userInfo!.firstName} ${item.userInfo!.lastName}",
                              isTile: true,
                              size: 16,
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
                        Expanded(
                          child: Container(),
                        ),
                        InkWell(
                          onTap: () {
                            controller.isConfirmLeaveRequest.value = false;
                            Get.back();
                          },
                          child: const Icon(
                            Icons.close,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    BaseText(
                      text:
                          "${"from".tr}${controller.formatDateTime(item.timeStart!)}",
                      colorText: AppColor.primaryBlue,
                      size: 13,
                    ),
                    SizedBox(
                      height: Get.height * 0.0025,
                    ),
                    BaseText(
                      text: item.timeEnd == null
                          ? "--:--"
                          : "${"to".tr}${controller.formatDateTime(item.timeEnd!)}",
                      colorText: AppColor.primaryBlue,
                      size: 13,
                    ),
                    SizedBox(
                      height: Get.height * 0.0025,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "${'reason'.tr}: ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: item.reason,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    Row(
                      children: [
                        Obx(
                          () => Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                primary: AppColor.colorButtonReject,
                                onPrimary: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                controller.isConfirmLeaveRequest.toggle();
                              },
                              child: Text(
                                controller.isConfirmLeaveRequest.value
                                    ? "cancel".tr
                                    : "rejected".tr,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Obx(
                          () => Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(0, 45),
                                primary: AppColor.colorButtonApproved,
                                onPrimary: const Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () async {
                                if (!controller.isConfirmLeaveRequest.value) {
                                  if (await controller.updateLeaveRequest(
                                      item.id.toString(),
                                      Numeral.STATUS_CODE_APPROVED)) {
                                    controller.getListLeaveRequest();
                                    Get.back();
                                  }
                                } else {
                                  if (await controller.updateLeaveRequest(
                                      item.id.toString(),
                                      Numeral.STATUS_CODE_REJECT)) {
                                    controller.getListLeaveRequest();
                                    Get.back();
                                  }
                                }
                              },
                              child: Text(
                                controller.isConfirmLeaveRequest.value
                                    ? "save".tr
                                    : "approved".tr,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.isConfirmLeaveRequest.value,
                        child: Container(
                          width: Numeral.WIDTH_SCREEN * 0.8,
                          height: Get.height * 0.2,
                          margin: EdgeInsets.only(
                            top: Get.height * 0.015,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 20),
                          decoration: BoxDecoration(
                              color: AppColor.lightPurple,
                              borderRadius: BorderRadius.circular(12),
                              border: (!controller.isValidReason.value)
                                  ? Border.all(
                                      color: AppColor.lightRed, width: 1.5)
                                  : null,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 2,
                                    blurRadius: 4)
                              ]),
                          child: TextField(
                            maxLength: 500,
                            maxLines: null,
                            controller: controller.textReasonController.value,
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                  color: (controller.isValidReason.value)
                                      ? AppColor.primaryGrey
                                      : AppColor.lightRed),
                              border: InputBorder.none,
                              hintText: "reason_reject".tr,
                              errorText: controller.textErrorReason.value == ""
                                  ? null
                                  : controller.textErrorReason.value.tr,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
