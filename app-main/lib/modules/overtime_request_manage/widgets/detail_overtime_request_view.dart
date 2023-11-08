import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/overtime_request_manage/controllers/overtime_request_manage_controller.dart';
import 'package:app_work_log/modules/overtime_request_manage/models/overtime_request_manage.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailOvertimeRequestView extends GetView<OverTimeRequestManageController> {
  final OvertimeRequestManage item;
  const DetailOvertimeRequestView({super.key, required this.item});

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
                      height: Get.height * 0.0025,
                    ),
                    const Divider(),
                    SizedBox(
                      height: Get.height * 0.0025,
                    ),
                    BaseText(
                      text:
                          "${"from".tr}${item.timeStart!}",
                      colorText: AppColor.primaryBlue,
                      size: 13,
                    ),
                    SizedBox(
                      height: Get.height * 0.0025,
                    ),
                    BaseText(
                      text: item.timeEnd == null
                          ? "--:--"
                          : "${"to".tr}${item.timeEnd!}",
                      colorText: AppColor.primaryBlue,
                      size: 13,
                    ),
                    SizedBox(
                      height: Get.height * 0.00125,
                    ),
                    const Divider(),
                    SizedBox(
                      height: Get.height * 0.00125,
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
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.0025,
                    ),
                    
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "${'status'.tr}: ",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: controller.setTextfromStatusCode(item.statusCode!),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: controller.setColorfromStatusCode(item.statusCode!),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.0025,
                    ),

                    Visibility(
                      visible: item.statusCode == Numeral.STATUS_CODE_REJECT,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "${'reason_reject'.tr}: ",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: item.reasonReject,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
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