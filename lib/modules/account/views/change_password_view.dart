import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_appbar.dart';
import 'package:attendance_fast/common/widgets/base_button_login.dart';
import 'package:attendance_fast/common/widgets/base_gradient_text.dart';
import 'package:attendance_fast/common/widgets/base_text_form_field.dart';
import 'package:attendance_fast/modules/account/controllers/change_password_controller.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
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
                const BaseAppBar(
                  title: "",
                  action: SizedBox(),
                  hasBack: true,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getTitleWidget(),
                      SizedBox(height: Get.height * 0.05),
                      getFormWidget(),
                      SizedBox(height: Get.height * 0.04),
                      getButton(),
                      SizedBox(height: Get.height * 0.1),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  getButton() {
    return Padding(
        padding: EdgeInsets.only(bottom: Get.height * 0.05),
        child: GestureDetector(
          onTap: () => controller.validateAndCallApi(),
          child: BaseButtonLogin(
            height: Get.height * 0.06,
            width: Numeral.WIDTH_SCREEN * 0.7,
            title: "save".tr,
            borderRadius: 14,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ));
  }

  getFormWidget() {
    return Form(
      key: controller.formKeyCreateStaff,
      child: Column(children: [
        getInputWidget(),
        const SizedBox(height: 18),
      ]),
    );
  }

  getInputWidget() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Numeral.WIDTH_SCREEN * 0.85,
            padding: const EdgeInsets.symmetric(vertical: 7),
            decoration: BoxDecoration(
                color: AppColor.lightPurple,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 2, blurRadius: 4)
                ]),
            child: Column(
              children: [
                BaseTextFormField(
                    prefixIcon: Icon(Icons.lock_reset,
                        color: AppColor.primaryGrey.withOpacity(0.8)),
                    label: "password".tr,
                    suffixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: InkWell(
                        onTap: () {
                          controller.obscurePassword.toggle();
                        },
                        child: Icon(
                          controller.obscurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    textInputType: TextInputType.visiblePassword,
                    obscureText: controller.obscurePassword.value,
                    controller: controller.textPassword,
                    validateFunction: controller.passwordValidateFunc),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Divider(),
                ),
                BaseTextFormField(
                    prefixIcon: Icon(Icons.lock,
                        color: AppColor.primaryGrey.withOpacity(0.8)),
                    label: 'new_password'.tr,
                    suffixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: InkWell(
                        onTap: () {
                          controller.obscureNewPassword.toggle();
                        },
                        child: Icon(
                          controller.obscureNewPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    textInputType: TextInputType.visiblePassword,
                    obscureText: controller.obscureNewPassword.value,
                    controller: controller.textNewPassword,
                    validateFunction: controller.newPasswordValidateFunc),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Divider(),
                ),
                BaseTextFormField(
                    prefixIcon: Icon(Icons.enhanced_encryption,
                        color: AppColor.primaryGrey.withOpacity(0.8)),
                    label: 'confirm_password'.tr,
                    suffixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: InkWell(
                        onTap: () {
                          controller.obscureConfirmPassword.toggle();
                        },
                        child: Icon(
                          controller.obscureConfirmPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    textInputType: TextInputType.visiblePassword,
                    obscureText: controller.obscureConfirmPassword.value,
                    controller: controller.textConfirmPassword,
                    validateFunction: controller.confirmPasswordValidateFunc),
              ],
            ),
          )
        ],
      ),
    );
  }

  getTitleWidget() {
    return Column(
      children: [
        GradientText(
          'change_password'.tr,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          gradient: LinearGradient(colors: [
            AppColor.primaryBlue,
            AppColor.primaryPurple,
          ]),
        ),
        Text(
          "change_your_password".tr,
          style: TextStyle(
              color: AppColor.primaryGrey,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
