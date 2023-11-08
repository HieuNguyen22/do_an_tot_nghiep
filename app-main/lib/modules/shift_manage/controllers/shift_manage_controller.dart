import 'dart:convert';
import 'dart:io';

import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/widgets/base_dialog.dart';
import 'package:app_work_log/modules/shift_manage/model/shift.dart';
import 'package:app_work_log/modules/shift_manage/provider/shift_manage_provider.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ShiftManageController extends GetxController {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var listShift = <ShiftManager>[ShiftManager(id: -1)].obs;

  RxString timeStart = "--:--".obs;
  RxString timeEnd = "--:--".obs;

  var textShift = TextEditingController().obs;

  var shiftChoose = ShiftManager().obs;
  var textNameFileCsv = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    getListShift();
  }

  refreshInputShift(){
    textShift.value.text = "";
    timeStart.value = "--:--";
    timeEnd.value = "--:--";
  }

  resetList(){
    listShift.value = [ShiftManager(id: -1)];
  }

  getListShift() async {
    resetList();
    listShift.value = await ShiftManageProvider().getListShiftofCompanyUserLogin();
  }

  Future<bool> addDShift() async {
    var result = await ShiftManageProvider().addShift(Global.companyId.toString(), textShift.value.text, timeStart.value, timeEnd.value, 1, 1);
    return result;
  }

  Future<bool> updateShift() async {
    shiftChoose.value.name = textShift.value.text;
    shiftChoose.value.timeStart = timeStart.value;
    shiftChoose.value.timeEnd = timeEnd.value;
    var result = await ShiftManageProvider().updateShift(shiftChoose.value.id!, textShift.value.text, timeStart.value, timeEnd.value);
    return result;
  }

  Future<bool> deleteShift() async {
    var result = await ShiftManageProvider().deleteShift(shiftChoose.value.id!);
    return result;
  }

  chooseItemShift(ShiftManager shiftManager){
    shiftChoose.value = shiftManager;
    textShift.value.text = shiftChoose.value.name!;
    timeStart.value = shiftChoose.value.timeStart!;
    timeEnd.value = shiftChoose.value.timeEnd!;
  }

  validateAdd() async {
    final FormState? form = formKey.currentState;
    if (!form!.validate()) {
      print('Form is invalid');
    } else {
        print('Form is valid');
        Get.back();
        if(await addDShift()){
          BaseDialog.getBaseDialog(
            context: Get.context!,
            title: "success".tr,
            desc: "success".tr,
            dialogType: DialogType.success,
            buttonColor: AppColor.primaryGreen,
            textColor: AppColor.primaryGreen);
          getListShift();
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
  }

  validateAndSaveEnroll() async {
    final FormState? form = formKey.currentState;
    if (!form!.validate()) {
      print('Form is invalid');
    } else {
        print('Form is valid');
        Get.back();
        if(await updateShift()){
          BaseDialog.getBaseDialog(
            context: Get.context!,
            title: "success".tr,
            desc: "success".tr,
            dialogType: DialogType.success,
            buttonColor: AppColor.primaryGreen,
            textColor: AppColor.primaryGreen);
          getListShift();
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
  }

  String? emptyValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else {
      return null;
    }
  }

  Future<void> exportListToCSV() async {
    List<List<dynamic>> rows = [];
    rows.add(['id_shift'.tr, 'name_shift'.tr, 'begin'.tr, 'end'.tr]);
    for (var shift in listShift) {
      rows.add([
        shift.id,
        shift.name,
        shift.timeStart,
        shift.timeEnd
      ]);
    }

    String csvString = const ListToCsvConverter().convert(rows);

    if (GetPlatform.isWeb) {
      Uint8List bytes = Uint8List.fromList(utf8.encode(csvString));

      await FileSaver.instance.saveFile(
        name:
            textNameFileCsv.value.text, 
        bytes: bytes,
        ext: 'csv',
        mimeType: MimeType.csv,
      );
    } else if (GetPlatform.isAndroid || GetPlatform.isIOS){
      String filePath = "${(GetPlatform.isAndroid ? await getExternalStorageDirectory() : await getApplicationSupportDirectory())!.path}/${textNameFileCsv.value.text}.csv";

      try {
        File file = File(filePath);
        await file.writeAsString(csvString);
        final result = await OpenFile.open(filePath);
        if (result.type != ResultType.done) {
          print('Could not open the file: ${result.message}');
        }
      } catch (e) {
        print("Error writing CSV file: $e");
      }
    }
  }

  validateConfirm() async {
    final FormState? form = formKey.currentState;
    if (!form!.validate()) {
      print('Form is invalid');
    } else {
      print('Form is valid');
      Get.back();
      exportListToCSV();
    }
  }
}
