import 'package:attendance_fast/modules/account/controllers/account_controller.dart';
import 'package:attendance_fast/modules/account/provider/update_profile_provider.dart';
import 'package:attendance_fast/modules/home/models/user_model.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfileController extends GetxController {
  final GlobalKey<FormState> formKeyCreateStaff = GlobalKey<FormState>();

  TextEditingController textCompanyName = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textFirstName = TextEditingController();
  TextEditingController textLastName = TextEditingController();
  TextEditingController textEmployeeID = TextEditingController();
  TextEditingController textAddress = TextEditingController();
  TextEditingController textPhoneNumber = TextEditingController();
  TextEditingController textStatusCode = TextEditingController();

  UserModel currentUser = UserModel();

  AccountController accountController = Get.find<AccountController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    currentUser = Get.arguments;
    setInitialData();
  }

  callApiUpdateProfile() async {
    var result = await UpdateProfileProvider().updateUserInfo(
        firstName: textFirstName.text,
        lastName: textLastName.text,
        address: textAddress.text,
        employeeId: textEmployeeID.text,
        phoneNumber: textPhoneNumber.text);

    if (result) {
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: "success".tr,
        desc: "success".tr,
        btnOkColor: AppColor.primaryGreen,
        btnOkOnPress: () {
          Get.back();
          accountController.callApiUserProvider();
          Get.back();
        },
        onDismissCallback: (type) {
          Get.back();
          accountController.callApiUserProvider();
          Get.back();
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
            Get.back();
          }).show();
    }
  }

  setInitialData() {
    textCompanyName.text = currentUser.companyInfo!.name ?? "";
    textEmail.text = currentUser.email ?? "";
    textFirstName.text = currentUser.firstName ?? "";
    textLastName.text = currentUser.lastName ?? "";
    textEmployeeID.text = currentUser.employeeCode ?? "";
    textAddress.text = currentUser.address ?? "";
    textPhoneNumber.text = currentUser.phoneNumber ?? "";

    if (currentUser.statusCode != null) {
      textStatusCode.text =
          (currentUser.statusCode == 1) ? "active".tr : "in_active".tr;
    }
  }

  resetInputField() {
    textFirstName.text = currentUser.firstName ?? "";
    textLastName.text = currentUser.lastName ?? "";
    textEmployeeID.text = currentUser.employeeCode ?? "";
    textAddress.text = currentUser.address ?? "";
    textPhoneNumber.text = currentUser.phoneNumber ?? "";
  }

  void validateAndCallApi() {
    final FormState? form = formKeyCreateStaff.currentState;
    if (!form!.validate()) {
      print('Form is invalid');
    } else {
      print('Form is valid');
      callApiUpdateProfile();
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
}
