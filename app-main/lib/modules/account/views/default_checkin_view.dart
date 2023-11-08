import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/account/controllers/default_checkin_controller.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DefaultCheckinView extends GetView<DefaultCheckinController> {
  const DefaultCheckinView({super.key});

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
            child: Obx(
              () => Theme(
                data: ThemeData(unselectedWidgetColor: AppColor.primaryPurple),
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
                            text: "default_checkin_method".tr,
                            isTile: true,
                            size: 20,
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                    ),
                    RadioListTile(
                      title: Text('location'.tr),
                      value: Numeral.TYPE_CHECKIN_LOCATION,
                      groupValue: controller.selectDefaultCheckin.value,
                      activeColor: AppColor.primaryBlue,
                      onChanged: (valueTypeCheckin) {
                        controller.selectTypeCheckin(valueTypeCheckin!);
                      },
                    ),
                    RadioListTile(
                      title: Text('wifi'.tr),
                      value: Numeral.TYPE_CHECKIN_WIFI,
                      groupValue: controller.selectDefaultCheckin.value,
                      activeColor: AppColor.primaryBlue,
                      onChanged: (valueTypeCheckin) {
                        controller.selectTypeCheckin(valueTypeCheckin!);
                      },
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    InkWell(
                      onTap: (){
                        controller.saveDefaultCheckin();
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
          )),
    );
  }
}
