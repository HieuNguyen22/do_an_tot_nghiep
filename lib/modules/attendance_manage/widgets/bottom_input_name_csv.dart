import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_button.dart';
import 'package:attendance_fast/common/widgets/base_text.dart';
import 'package:attendance_fast/common/widgets/base_text_form_field.dart';
import 'package:attendance_fast/modules/attendance_manage/controllers/attendance_manage_controller.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomInputNameCsv extends GetView<AttendanceCheckInManageController> {
  const BottomInputNameCsv({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
        height: Get.height * 0.32,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseText(
              text: "noti_input_name_file_csv".tr,
              isTile: true,
              size: 24,
            ),
            const Divider(),
            BaseTextFormField(
              controller: controller.textNameFileCsv.value,
              prefixIcon: Icon(Icons.code,
                  color: AppColor.primaryGrey.withOpacity(0.8)),
              label: "name_file_csv".tr,
              validateFunction: controller.emptyValidateFunc,
            ),
            Container(
              margin: EdgeInsets.only(
                left: Numeral.WIDTH_SCREEN * 0.025,
                right: Numeral.WIDTH_SCREEN * 0.025,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: BaseButton(
                      height: Get.height * 0.05,
                      width: Numeral.WIDTH_SCREEN * 0.35,
                      title: "cancel".tr,
                      colorBegin: AppColor.colorButtonReject,
                      colorEnd: AppColor.colorButtonReject.withOpacity(0.8),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.validateConfirm();
                    },
                    child: BaseButton(
                      height: Get.height * 0.05,
                      width: Numeral.WIDTH_SCREEN * 0.35,
                      title: "confirm".tr,
                      colorBegin: AppColor.colorButtonApproved,
                      colorEnd: AppColor.colorButtonApproved.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
