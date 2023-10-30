import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_appbar.dart';
import 'package:attendance_fast/common/widgets/base_button_login.dart';
import 'package:attendance_fast/common/widgets/base_gradient_text.dart';
import 'package:attendance_fast/common/widgets/base_text_form_field.dart';
import 'package:attendance_fast/modules/login/controllers/forgot_password_controller.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

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
          onTap: () {
            controller.clickSave();
          },
          child: BaseButtonLogin(
            height: Get.height * 0.06,
            width: Numeral.WIDTH_SCREEN * 0.7,
            title: "send".tr,
            borderRadius: 14,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ));
  }

  getFormWidget() {
    return Form(
      key: controller.formKeyCreateStaff,
      child: Obx(
        () => Column(children: [
          getInputWidget(),
          Visibility(
            visible: controller.steps.value != Numeral.STEP_INPUT_EMAIL,
            child: inputConfirmCode(),
          ),
          Visibility(
            visible: controller.steps.value == Numeral.STEP_INPUT_PASSWORD_NEW,
            child: inputPasswordNew()),
        ]),
      ),
    );
  }

  Widget getInputWidget() {
    return Container(
      width: Numeral.WIDTH_SCREEN * 0.85,
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
          color: AppColor.lightPurple,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
          ]),
      child: BaseTextFormField(
        prefixIcon:
            Icon(Icons.email, color: AppColor.primaryGrey.withOpacity(0.8)),
        label: "email".tr,
        controller: controller.textEmail,
        validateFunction: controller.emailValidateFunc,
      ),
    );
  }

  Widget inputConfirmCode() {
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.02,),
      width: Numeral.WIDTH_SCREEN * 0.85,
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
          color: AppColor.lightPurple,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
          ]),
      child: BaseTextFormField(
        prefixIcon:
            Icon(Icons.code, color: AppColor.primaryGrey.withOpacity(0.8)),
        label: "code".tr,
        controller: controller.textCode,
        validateFunction: controller.emptyValidateFunc,
      ),
    );
  }

  Widget inputPasswordNew() {
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.02,),
      width: Numeral.WIDTH_SCREEN * 0.85,
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
          color: AppColor.lightPurple,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
          ]),
      child: Obx(
        () => Column(
          children: [
            BaseTextFormField(
              prefixIcon: Icon(Icons.password,
                  color: AppColor.primaryGrey.withOpacity(0.8)),
              label: "new_password".tr,
              obscureText: controller.obscureNewPassword.value,
              controller: controller.textNewPassword,
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
              validateFunction: controller.passwordValidateFunc,
            ),
            Divider(),
            BaseTextFormField(
              prefixIcon: Icon(Icons.password,
                  color: AppColor.primaryGrey.withOpacity(0.8)),
              label: "confirm_password".tr,
              textInputType: TextInputType.visiblePassword,
              obscureText: controller.obscureConfirmPassword.value,
              controller: controller.textConfirmPassword,
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
              validateFunction: controller.confirmPasswordValidateFunc,
            ),
          ],
        ),
      ),
    );
  }

  getTitleWidget() {
    return Column(
      children: [
        GradientText(
          'forgot_password'.tr,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          gradient: LinearGradient(colors: [
            AppColor.primaryBlue,
            AppColor.primaryPurple,
          ]),
        ),
        Text(
          "reset_your_password".tr,
          style: TextStyle(
              color: AppColor.primaryGrey,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
