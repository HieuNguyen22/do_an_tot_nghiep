import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_button.dart';
import 'package:attendance_fast/common/widgets/base_text.dart';
import 'package:attendance_fast/modules/account/controllers/default_shift_controller.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultShiftView extends GetView<DefaultShiftController> {
  const DefaultShiftView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: Numeral.WIDTH_SCREEN,
        height: Get.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/common/img_bg_2.png"),
                fit: BoxFit.fill)),
        child: Padding(
          padding: EdgeInsets.only(
              top: Get.height * 0.04,
              right: Numeral.WIDTH_SCREEN * 0.03,
              left: Numeral.WIDTH_SCREEN * 0.03),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.chevron_left,
                                size: 32,
                              )),
                        ],
                      ),
                    ),
                    BaseText(
                      text: "shift".tr,
                      isTile: true,
                      size: 24,
                    ),
                    Expanded(child: Container())
                  ],
                ),
              ),
              Obx(
                () => Expanded(
                  child: (controller.listShift.length == 1 &&
                          controller.listShift[0].id == -1)
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColor.primaryPurple),
                          ),
                        )
                      : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.listShift.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          controller.selectShift(index);
                        },
                        child: Obx(
                          () => RadioListTile(
                            title: Text(controller.listShift[index].name ??
                                "not_select_default_shift".tr),
                            value: index,
                            groupValue: controller.selectDefaultShift.value,
                            activeColor: AppColor.primaryBlue,
                            onChanged: (valueDefaultShift) {
                              controller.selectShift(valueDefaultShift!);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              InkWell(
                onTap: () {
                  controller.saveDefaultShift();
                },
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: Get.height * 0.025,
                  ),
                  child: BaseButton(
                      height: Get.height * 0.06,
                      width: Numeral.WIDTH_SCREEN * 0.9,
                      title: "save".tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
