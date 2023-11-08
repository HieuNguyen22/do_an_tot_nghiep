import 'dart:io';

import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/widgets/base_dialog.dart';
import 'package:app_work_log/modules/company_profile/models/company.dart';
import 'package:app_work_log/modules/company_profile/provider/company_profile_provider.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

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

  shareCompanyCode() async {
    if (companyInfo.value.companyCode != null) {
      final image = await QrPainter(
        data: companyInfo.value.companyCode!,
        version: QrVersions.auto,
        gapless: false,
        color: Colors.black,
        emptyColor: Colors.white,
      ).toImageData(200.0);

      final filename = 'qr_code.png';
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/$filename').create();
      var bytes = image!.buffer.asUint8List();
      await file.writeAsBytes(bytes);

      try {
        final result = await Share.shareXFiles([XFile(file.path)],
            text: '${"company".tr}: ${companyInfo.value.name}\n${"company_code".tr}: ${companyInfo.value.companyCode}');
        print('Sharing success: $result');
      } catch (e) {
        print('Error sharing file: $e');
      }
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
