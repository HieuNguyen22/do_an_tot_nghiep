import 'dart:convert';
import 'dart:io';

import 'package:app_work_log/modules/staff_manage/models/staff.dart';
import 'package:app_work_log/modules/staff_manage/provider/staff_manage_provider.dart';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

class StaffManageController extends GetxController {
  var listStaff = <StaffManage>[StaffManage(id: -1)].obs;
  var textSearch = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var textNameFileCsv = TextEditingController().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getListStaff();
  }

  resetListStaff() {
    listStaff.value = [StaffManage(id: -1)];
  }

  getListStaff() async {
    resetListStaff();
    listStaff.value =
        await StaffManageProvider().getListStaffoffCompanyUserLogin();
    if (textSearch.text != "") {
      listStaff.value = listStaff
          .where((value) =>
              (value.firstName == null
                      ? ""
                      : value.firstName!.trim().toUpperCase())
                  .contains(textSearch.text.trim().toUpperCase()) ||
              (value.lastName == null
                      ? ""
                      : value.lastName!.trim().toUpperCase())
                  .contains(textSearch.text.trim().toUpperCase()) ||
              (value.employeeCode!.isEmpty ? "" : value.employeeCode!)
                  .contains(textSearch.text))
          .toList();
    }
  }

  Future<void> exportListToCSV() async {
    List<List<dynamic>> rows = [];
    rows.add([
      'id_employee'.tr,
      'first_name'.tr,
      'last_name'.tr,
      'email'.tr,
      'address'.tr,
      'phone_number'.tr
    ]);
    for (var staff in listStaff) {
      rows.add([
        staff.employeeCode,
        staff.firstName,
        staff.lastName,
        staff.email,
        staff.address ?? "",
        staff.phoneNumber ?? ""
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

  String? emptyValidateFunc(String? value) {
    if (value == null || value.isEmpty) {
      return "please_fill_this_field".tr;
    } else {
      return null;
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
