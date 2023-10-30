import 'package:attendance_fast/common/global.dart';
import 'package:attendance_fast/common/widgets/base_dialog.dart';
import 'package:attendance_fast/modules/company_profile/models/company.dart';
import 'package:attendance_fast/modules/company_profile/provider/company_profile_provider.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyProfileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var editCompany = false.obs;
  var editAdmin = false.obs;

  var companyInfo = CompanyModel().obs;

  var textCompanyName = TextEditingController().obs;
  var textRepresentative = TextEditingController().obs;
  var textCode = TextEditingController().obs;
  var textEmail = TextEditingController().obs;
  var textPhoneNumber = TextEditingController().obs;
  var textField = TextEditingController().obs;
  var textNumberWorkes = TextEditingController().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getInfoCompany();
    setInfoCompanytoTextField();
  }

  getInfoCompany() async {
    companyInfo.value = await CompanyProfileProvider()
        .getInfoCompanyUserLogin(Global.companyId.toString());
  }

  setInfoCompanytoTextField() {
    textCompanyName.value.text = companyInfo.value.name!;
    textRepresentative.value.text = companyInfo.value.representativeName!;
    textCode.value.text = companyInfo.value.companyCode!;
    textEmail.value.text = companyInfo.value.adminInfo!.email!;
    textPhoneNumber.value.text = companyInfo.value.adminInfo!.phoneNumber ?? "";
    //textField.value.text = companyInfo.value.name!;
    textNumberWorkes.value.text = companyInfo.value.numberStaff.toString();
  }

  saveInfoCompany() async {
    companyInfo.value.name = textCompanyName.value.text;
    companyInfo.value.representativeName = textRepresentative.value.text;
    companyInfo.value.companyCode = textCode.value.text;
    if (await updateWorkInfoStaff()) {
      BaseDialog.getBaseDialog(
          context: Get.context!,
          title: "success".tr,
          desc: "success".tr,
          dialogType: DialogType.success,
          buttonColor: AppColor.primaryGreen,
          textColor: AppColor.primaryGreen);
    } else {
      BaseDialog.getBaseDialog(
          context: Get.context!,
          title: "error".tr,
          desc: "error".tr,
          dialogType: DialogType.error,
          buttonColor: AppColor.lightRed,
          textColor: AppColor.lightRed);
    }
  }

  saveInfoAdmin() async {
    companyInfo.value.adminInfo!.phoneNumber = textPhoneNumber.value.text;
    if (await updateWorkInfoStaff()) {
      BaseDialog.getBaseDialog(
          context: Get.context!,
          title: "success".tr,
          desc: "success".tr,
          dialogType: DialogType.success,
          buttonColor: AppColor.primaryGreen,
          textColor: AppColor.primaryGreen);
    } else {
      BaseDialog.getBaseDialog(
          context: Get.context!,
          title: "error".tr,
          desc: "error".tr,
          dialogType: DialogType.error,
          buttonColor: AppColor.lightRed,
          textColor: AppColor.lightRed);
    }
  }

  Future<bool> updateWorkInfoStaff() async {
    var result = await CompanyProfileProvider()
        .updateInfoCompany(companyInfo.value.id!.toString(), companyInfo.value);
    return result;
  }

  String? emptyValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else {
      return null;
    }
  }

  Future<bool> validateUpdate() async {
    final FormState? form = formKey.currentState;
    if (!form!.validate()) {
      print('Form is invalid');
      return false;
    } else {
      print('Form is valid');
      return true;
    }
  }
}
