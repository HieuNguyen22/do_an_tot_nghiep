import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final authProvider = AuthProvider();
  var email = TextEditingController();
  var password = TextEditingController();
  var username = TextEditingController();
  var confirmPassword = TextEditingController();
  var textErrorUsername = "".obs;
  var textErrorEmail = "".obs;
  var textErrorPassword = "".obs;
  var textErrorConfirmPassword = "".obs;
  var checkConfirm = true.obs;
  createAccount() async {
    refreshText();
    if (password.text != confirmPassword.text) {
      textErrorConfirmPassword.value = "confirmation-assword-not-match".tr;
      checkConfirm.value = false;
    }
    if (username.text.isEmpty) {
      textErrorUsername.value = "must-not-leave-blank".tr;
      checkConfirm.value = false;
    }
    if (email.text.isEmpty) {
      textErrorEmail.value = "must-not-leave-blank".tr;
      checkConfirm.value = false;
    }
    if (!EmailValidator.validate(email.text)) {
      textErrorEmail.value = "invalid-email".tr;
      checkConfirm.value = false;
    }
    if (password.text.isEmpty) {
      textErrorPassword.value = "must-not-leave-blank".tr;
      checkConfirm.value = false;
    } else if (password.text.trim().length < 8) {
      textErrorPassword.value = "password-least-8-characters-long".tr;
      checkConfirm.value = false;
    }
    if (confirmPassword.text.isEmpty) {
      textErrorConfirmPassword.value = "must-not-leave-blank".tr;
      checkConfirm.value = false;
    }
    if (checkConfirm.value) {
      showLoading();
      var register = Register(
          userName: username.text, email: email.text, password: password.text);
      try {
        await authProvider.registerOnTheApp(register);
        showToast("sign-up-successfully".tr);
        Get.offAllNamed(Routes.LOGIN_SET_PASSWORD);
      } catch (e) {
        showToast("sign-up-failed".tr);
        closeLoading();
      }
      closeLoading();
    }
  }

  refreshText() {
    checkConfirm.value = true;
    textErrorUsername.value = "";
    textErrorEmail.value = "";
    textErrorPassword.value = "";
    textErrorConfirmPassword.value = "";
  }
}
