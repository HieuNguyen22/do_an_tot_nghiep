import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/utils/dialog.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/staff_manage/models/department.dart';
import 'package:app_work_log/modules/staff_manage/models/staff.dart';
import 'package:app_work_log/modules/staff_manage/provider/profile_staff_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class ProfileStaffController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Rx<StaffManage> staff = StaffManage().obs;

  var textEmployeeID = TextEditingController().obs;

  var textEmail = TextEditingController().obs;
  var textNumberPhone = TextEditingController().obs;
  var textAddress = TextEditingController().obs;

  var editWorkInfo = false.obs;
  var editPersonalInfo = false.obs;

  var isActive = false.obs;

  Rx<String> selectedDropBox = "department".tr.obs;
  var selectDepartmentManage = DepartmentManage().obs;
  RxBool isValidManager = true.obs;
  var listDepartment = <DepartmentManage>[].obs;
  final TextEditingController searchDropBoxController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await getListDepartment();
    staff.value = Get.arguments;
    selectDepartmentManage.value = listDepartment.firstWhere(
        (item) => item.id == staff.value.departmentId,
        orElse: () => DepartmentManage());
    if (selectDepartmentManage.value.id != null) {
      updateSelectedDepartment(selectDepartmentManage.value);
    }
    textEmployeeID.value.text = staff.value.employeeCode ?? "";
    textEmail.value.text = staff.value.email!;
    textNumberPhone.value.text = "";
    textAddress.value.text = staff.value.address ?? "";
    isActive.value =
        staff.value.statusCode == Numeral.STATUS_CODE_ACTIVE ? true : false;
  }

  saveWorkInfoStaff() {
    if (selectDepartmentManage.value.id != null) {
      staff.value.departmentId = selectDepartmentManage.value.id;
    }
    staff.value.employeeCode = textEmployeeID.value.text;
  }

  Future<bool> updateWorkInfoStaff() async {
    saveWorkInfoStaff();
    showLoading();
    var result = await ProfileStaffProvider()
        .updateWorkInfoStaff(staff.value.id!.toString(), staff.value);
    closeLoading();
    return result;
  }

  Future<bool> activeStaff() async {
    isActive.toggle();
    staff.value.statusCode =
        staff.value.statusCode == Numeral.STATUS_CODE_ACTIVE
            ? Numeral.STATUS_CODE_INACTIVE
            : Numeral.STATUS_CODE_ACTIVE;
    showLoading();
    var result = await ProfileStaffProvider()
        .updateWorkInfoStaff(staff.value.id!.toString(), staff.value);
    closeLoading();
    return result;
  }

  getListDepartment() async {
    listDepartment.value = await ProfileStaffProvider()
        .getListDepartmentofCompanyUserLogin(Global.companyId.toString());
  }

  updateSelectedDepartment(DepartmentManage departmentManage) {
    selectDepartmentManage.value = departmentManage;
    selectedDropBox.value =
        "${selectDepartmentManage.value.name} - ${selectDepartmentManage.value.managerInfo?.firstName} ${selectDepartmentManage.value.managerInfo?.lastName}";
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
