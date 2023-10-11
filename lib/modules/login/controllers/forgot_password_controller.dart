import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final GlobalKey<FormState> formKeyCreateStaff = GlobalKey<FormState>();

  TextEditingController textEmail = TextEditingController();
  TextEditingController textCode = TextEditingController();
  TextEditingController textNewPassword = TextEditingController();
  TextEditingController textConfirmPassword = TextEditingController();

  RxBool obscureNewPassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;

  var steps = Numeral.STEP_INPUT_EMAIL.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  clickSave() {
    if (steps.value == Numeral.STEP_INPUT_EMAIL) {
      validateEmail();
    } else if (steps.value == Numeral.STEP_INPUT_CODE) {
      validateCode();
    } else if (steps.value == Numeral.STEP_INPUT_PASSWORD_NEW) {
      validatePassword();
    }
  }

  void validateEmail() {
    final FormState? form = formKeyCreateStaff.currentState;
    if (!form!.validate()) {
      print('Form is invalid');
    } else {
      print('Form is valid');
      //steps.value = Numeral.STEP_INPUT_CODE;
      sendRequestForgotPassword();
    }
  }

  void validateCode() {
    final FormState? form = formKeyCreateStaff.currentState;
    if (!form!.validate()) {
      print('Form is invalid');
    } else {
      print('Form is valid');
      steps.value = Numeral.STEP_INPUT_PASSWORD_NEW;
    }
  }

  void validatePassword() {
    final FormState? form = formKeyCreateStaff.currentState;
    if (!form!.validate()) {
      print('Form is invalid');
    } else {
      print('Form is valid');
    }
  }

  void sendRequestForgotPassword() async {
    showLoading();
    var result = await ForgotPasswordProvider()
        .sendRequestForgotPassword(textEmail.text.trim());
    closeLoading();
    if (result) {
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: "success".tr,
        desc: "noti_check_mail_forgot_password".tr,
        btnOkColor: AppColor.primaryGreen,
        btnOkOnPress: () {
          textEmail.text = "";
        },
        onDismissCallback: (type) {},
      ).show();
    } else {
      AwesomeDialog(
          context: Get.context!,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: "error".tr,
          desc: "noti_mail_not_registered".tr,
          btnOkColor: AppColor.lightRed,
          btnOkOnPress: () {
            textEmail.text = "";
          }).show();
    }
  }

  String? emailValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else if (!value.isEmail) {
      return "Please enter the email in the correct format";
    } else {
      return null;
    }
  }

  String? emptyValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else {
      return null;
    }
  }

  String? passwordValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else if (value.length < 8) {
      return "password_least_characters_long".tr;
    } else {
      return null;
    }
  }

  String? confirmPasswordValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else if (value.length < 8) {
      return "password_least_characters_long".tr;
    } else if (value != textNewPassword.text) {
      return "re-entered_password_not match".tr;
    } else {
      return null;
    }
  }
}
