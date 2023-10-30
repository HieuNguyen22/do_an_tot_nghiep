import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_button.dart';
import 'package:attendance_fast/common/widgets/base_text.dart';
import 'package:attendance_fast/modules/account/controllers/language_controller.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageView extends GetView<LanguageController> {
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
                            text: "language".tr,
                            isTile: true,
                            size: 24,
                          ),
                          Expanded(child: Container())
                        ],
                      ),
                    ),
                    RadioListTile(
                      title: Text('language_en'.tr),
                      value: Numeral.LANGUAGE_EN,
                      groupValue: controller.selectLanguage.value,
                      activeColor: AppColor.primaryBlue,
                      onChanged: (valueLanguage) {
                        controller.selectLanguage(valueLanguage);
                      },
                    ),
                    RadioListTile(
                      title: Text('language_vn'.tr),
                      value: Numeral.LANGUAGE_VN,
                      groupValue: controller.selectLanguage.value,
                      activeColor: AppColor.primaryBlue,
                      onChanged: (valueLanguage) {
                        controller.selectLanguage(valueLanguage);
                      },
                    ),
                    // RadioListTile(
                    //   title: Text('language_jp'.tr),
                    //   value: Numeral.LANGUAGE_JP,
                    //   groupValue: controller.selectLanguage.value,
                    //   activeColor: AppColor.primaryBlue,
                    //   onChanged: (valueLanguage) {
                    //     controller.selectLanguage(valueLanguage);
                    //   },
                    // ),
                    Expanded(
                      child: Container(),
                    ),
                    InkWell(
                      onTap: (){
                        controller.saveLanguage();
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
