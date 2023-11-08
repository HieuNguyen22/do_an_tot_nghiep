import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_dialog.dart';
import 'package:app_work_log/modules/department_manage/model/department_manager.dart';
import 'package:app_work_log/modules/department_manage/model/employee_company.dart';
import 'package:app_work_log/modules/department_manage/model/manager_company.dart';
import 'package:app_work_log/modules/department_manage/provider/department_manage_provider.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:csv/csv.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class DepartmentManageController extends GetxController {
  var listDepartment = <DepartmentManage>[DepartmentManage(id: -1)].obs;
  var listManager = <ManagerCompany>[].obs;
  var listEmployee = <EmployeeCompany>[].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var textNameFileCsv = TextEditingController().obs;

  var textDepartment = TextEditingController().obs;

  var departmentChoose = DepartmentManage().obs;

  Rx<String> selectedDropBox = "send_to".tr.obs;
  var selectManagerManage = EmployeeCompany().obs;
  RxBool isValidManager = true.obs;
  final TextEditingController searchDropBoxController = TextEditingController();

  updateSelectedManager(EmployeeCompany employeeCompany) {
    selectManagerManage.value = employeeCompany;
    selectedDropBox.value =
        "${selectManagerManage.value.employeeCode} - ${selectManagerManage.value.firstName} ${selectManagerManage.value.lastName}";
  }

  resetList() {
    listDepartment.value = [DepartmentManage(id: -1)];
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    getListDepartment();
    getEmployee();
  }

  refreshInput() {
    textDepartment.value.text = "";
    selectedDropBox.value = "send_to".tr;
    selectManagerManage.value = EmployeeCompany();
  }

  getListManager() async {
    listManager.value =
        await DepartmentManageProvider().getListManagerofCompanyUserLogin();
  }

  getEmployee() async {
    listEmployee.value =
        await DepartmentManageProvider().getListEmployeeCompanyUserLogin();
  }

  getListDepartment() async {
    resetList();
    listDepartment.value = await DepartmentManageProvider()
        .getListDepartmentofCompanyUserLogin(Global.companyId.toString());
  }

  Future<bool> addDepartment() async {
    var result = await DepartmentManageProvider().addDepartment(
        textDepartment.value.text,
        Global.companyId,
        selectManagerManage.value.id ?? Numeral.CODE_NOT_MANAGER,
        Numeral.STATUS_CODE_DEFAULT);
    return result;
  }

  Future<bool> updateDepartment() async {
    departmentChoose.value.name = textDepartment.value.text;
    departmentChoose.value.managerId = selectManagerManage.value.id;
    var result = await DepartmentManageProvider().updateDepartment(
        departmentChoose.value.id!,
        textDepartment.value.text,
        Global.companyId,
        selectManagerManage.value.id ?? Numeral.CODE_NOT_MANAGER);
    return result;
  }

  Future<bool> deleteShift() async {
    var result = await DepartmentManageProvider()
        .deleteDepartment(departmentChoose.value.id!);
    return result;
  }

  chooseItemDepartment(int index, DepartmentManage departmentManage) {
    departmentChoose.value = departmentManage;
    textDepartment.value.text = departmentChoose.value.name!;
    if (departmentManage.managerInfo == null) {
      selectManagerManage.value = EmployeeCompany();
      selectedDropBox.value = "send_to".tr;
    } else {
      selectManagerManage.value = listEmployee.firstWhere(
          (item) => item.id == departmentManage.managerInfo!.id,
          orElse: () => EmployeeCompany());
      if (selectManagerManage.value.id != null) {
        updateSelectedManager(selectManagerManage.value);
      }
    }
  }

  validateAdd() async {
    final FormState? form = formKey.currentState;
    if (!form!.validate()) {
      print('Form is invalid');
    } else {
      print('Form is valid');
      Get.back();
      if (await addDepartment()) {
        BaseDialog.getBaseDialog(
            context: Get.context!,
            title: "success".tr,
            desc: "success".tr,
            dialogType: DialogType.success,
            buttonColor: AppColor.primaryGreen,
            textColor: AppColor.primaryGreen);
        getEmployee();
        getListDepartment();
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
      if (await updateDepartment()) {
        BaseDialog.getBaseDialog(
            context: Get.context!,
            title: "success".tr,
            desc: "success".tr,
            dialogType: DialogType.success,
            buttonColor: AppColor.primaryGreen,
            textColor: AppColor.primaryGreen);
        getEmployee();
        getListDepartment();
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
    rows.add(['id_department'.tr, 'name_department'.tr, 'manager_department'.tr, 'email'.tr, 'phone_number'.tr]);
    for (var department in listDepartment) {
      rows.add([
        department.id,
        department.name,
        "${department.managerInfo!.employeeCode} - ${department.managerInfo!.firstName} ${department.managerInfo!.lastName}",
        department.managerInfo!.email,
        department.managerInfo!.phoneNumber,
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
