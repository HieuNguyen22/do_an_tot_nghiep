import 'package:app_work_log/modules/account/provider/change_password_provider.dart';
import 'package:app_work_log/oauth2/service/auth_service.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final GlobalKey<FormState> formKeyCreateStaff = GlobalKey<FormState>();

  TextEditingController textPassword = TextEditingController();
  TextEditingController textNewPassword = TextEditingController();
  TextEditingController textConfirmPassword = TextEditingController();

  RxBool obscurePassword = true.obs;
  RxBool obscureNewPassword = true.obs;
  RxBool obscureConfirmPassword = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void validateAndCallApi() {
    final FormState? form = formKeyCreateStaff.currentState;
    if (!form!.validate()) {
      print('Form is invalid');
    } else {
      print('Form is valid');
      callApiChangePassword();
    }
  }

  /// Sign up staff  user
  void callApiChangePassword() async {
    var result = await ChangePasswordProvider().changePassword(
        password: textPassword.text,
        newPassword: textNewPassword.text,
        confirmPassword: textConfirmPassword.text);

    if (result) {
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: "success".tr,
        desc: "success".tr,
        btnOkColor: AppColor.primaryGreen,
        btnOkOnPress: () {
          Get.find<AuthService>().logout();
        },
        onDismissCallback: (type) {
          Get.find<AuthService>().logout();
        },
      ).show();
    } else {
      AwesomeDialog(
              context: Get.context!,
              dialogType: DialogType.error,
              animType: AnimType.scale,
              title: "error".tr,
              desc: "error".tr,
              btnOkColor: AppColor.lightRed,
              btnOkOnPress: () {
                // Get.back();
              })
          .show();
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

  String? newPasswordValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else if (value.length < 8) {
      return "password_least_characters_long".tr;
    } else if (value == textPassword.text) {
      return "The new password must not match the old password.";
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
