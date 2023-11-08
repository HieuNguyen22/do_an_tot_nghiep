import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_work_log/common/utils/dialog.dart';
import 'package:app_work_log/oauth2/provider/auth_provider.dart';
import 'package:app_work_log/oauth2/service/auth_service.dart';
import 'package:app_work_log/routes/app_pages.dart';

class LoginController extends GetxController {
  final authProvider = AuthProvider();
  final authService = Get.find<AuthService>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var showPassword = false.obs;
  var textEmail = TextEditingController();
  var textPassword = TextEditingController();

  var statusSaveInfoLogin = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    statusSaveInfoLogin.value = Get.find<AuthService>().saveInfoLogin ?? false;
    textEmail.text = Get.find<AuthService>().emailLogin ?? "";
    textPassword.text = Get.find<AuthService>().passwordLogin ?? "";
  }

  checkLogin() {
    if (authService.authed.value) {
      return Get.offAllNamed(Routes.HOME);
    }
    Get.toNamed(Routes.LOGIN);
  }

  validateAndLogin() async {
    final FormState? form = formKey.currentState;
    if (!form!.validate()) {
      print('Form is invalid');
    } else {
      print('Form is valid');
      if(statusSaveInfoLogin.value){
        Get.find<AuthService>().setEmailLogin(textEmail.text);
        Get.find<AuthService>().setPasswordLogin(textPassword.text);
      } else {
        Get.find<AuthService>().clearInfoLogin();
      }
      showLoading();
      try {
        final result = await authProvider.loginOnApp(textEmail.text, textPassword.text);
        Get.find<AuthService>().login(
            token: result["token"],
            refreshToken: result["token"],
            id:result["id"].toString(),
            routeName: Routes.HOME);
        textEmail.clear();
        textPassword.clear();
      } catch (e) {
        showToast("login_failed".tr);
        closeLoading();
      }
      closeLoading();
    }
  }

  String? emptyValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else {
      return null;
    }
  }
}
