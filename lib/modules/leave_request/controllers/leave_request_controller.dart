import 'package:attendance_fast/common/global.dart';
import 'package:attendance_fast/common/widgets/base_dialog.dart';
import 'package:attendance_fast/modules/home/models/statistic_model.dart';
import 'package:attendance_fast/modules/leave_request/models/manager_model.dart';
import 'package:attendance_fast/modules/leave_request/provider/leave_request_provider.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeaveRequestController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxString dateStart = "----/--/--".obs;
  RxString dateEnd = "----/--/--".obs;

  RxString timeStart = "--:--".obs;
  RxString timeEnd = "--:--".obs;

  final TextEditingController hourTotalController = TextEditingController();
  final TextEditingController minuteTotalController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController searchDropBoxController = TextEditingController();

  RxBool isValidReason = true.obs;
  RxBool isValidManager = true.obs;
  RxBool isValidDate = true.obs;
  RxBool isValidTimeStart = true.obs;
  RxBool isValidTimeEnd = true.obs;

  var listManager = <ManagerModel>[].obs;
  RxInt selectedManagerId = 0.obs;
  RxList<String> itemsDropBox = <String>[].obs;
  Rx<String> selectedDropBox = "send_to".tr.obs;


  @override
  void dispose() {
    searchDropBoxController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    callApiManagerOfCompany();
  }

  updateSelectedManager(ManagerModel manager) {
    selectedDropBox.value =
        "${manager.name} - ${manager.managerInfo?.firstName} ${manager.managerInfo?.lastName}";
    selectedManagerId.value = manager.managerInfo!.id!;
  }

  submit() {
    // Check valid manager field
    validateManager();

    // Check valid date field
    validateDate();

    // Check valid time start field
    validateTimeStart();

    // Check valid time end field
    validateTimeEnd();

    // Check valid reason field
    validateReason();

    // Check valid hour, minute field
    final FormState? form = formKey.currentState;
    if (!form!.validate()) {
    } else {}

    if (isValidManager.value &&
        isValidDate.value &&
        isValidTimeStart.value &&
        isValidTimeEnd.value &&
        isValidReason.value &&
        form.validate()) {
      print("----------- VALID");

      String timeStartRequest = dateStart.value + " " + timeStart.value;
      String timeEndRequest = dateEnd.value + " " + timeEnd.value;
      String durationRequest =
          hourTotalController.text + ":" + minuteTotalController.text;

      callApiSendLeaveRequestProvider(
          companyId: Global.companyId,
          userId: Global.userId,
          toApproveId: selectedManagerId.value,
          timeStart: timeStartRequest,
          timeEnd: timeEndRequest,
          duration: durationRequest,
          reason: reasonController.text);
    } else {
      print("----------- INVALID");
    }
  }

  /// Get manager of company
  Future<void> callApiManagerOfCompany() async {
    var result =
        await LeaveRequestProvider().getListManagerofCompanyUserLogin();
    if (result.isNotEmpty) {
      listManager.value = result;
    }
  }

  /// Send leave request
  void callApiSendLeaveRequestProvider(
      {required int companyId,
      required int userId,
      required int toApproveId,
      required String timeStart,
      required String timeEnd,
      required String duration,
      required String reason}) async {
    bool result = await LeaveRequestProvider().sendLeaveRequest(
        companyId: companyId,
        userId: userId,
        toApproveId: toApproveId,
        timeStart: timeStart,
        timeEnd: timeEnd,
        duration: duration,
        reason: reason);

    if (!result) {
      BaseDialog.getBaseDialog(
        context: Get.context!,
        title: "error".tr,
        desc: "sign_up_error".tr,
        buttonColor: AppColor.lightRed,
        dialogType: DialogType.error,
      );
    } else {
      AwesomeDialog(
        context: Get.context!,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: "success".tr,
        desc: "success".tr,
        btnOkColor: AppColor.primaryGreen,
        btnOkOnPress: () {
          Get.back();
          Get.back();
        },
      ).show();
    }
  }

  validateManager() {
    if (selectedDropBox.value.isEmpty ||
        selectedDropBox.value == "send_to".tr) {
      isValidManager.value = false;
    } else {
      isValidManager.value = true;
    }
  }

  validateDate() {
    if ((dateStart.value.isEmpty || dateStart.value == "----/--/--") ||
        (dateEnd.value.isEmpty || dateEnd.value == "----/--/--")) {
      isValidDate.value = false;
    } else {
      isValidDate.value = true;
    }
  }

  validateTimeStart() {
    if ((timeStart.value.isEmpty || timeStart.value == "--:--")) {
      isValidTimeStart.value = false;
    } else {
      isValidTimeStart.value = true;
    }
  }

  validateTimeEnd() {
    if ((timeEnd.value.isEmpty || timeEnd.value == "--:--")) {
      isValidTimeEnd.value = false;
    } else {
      isValidTimeEnd.value = true;
    }
  }

  validateReason() {
    if (reasonController.text.isEmpty) {
      isValidReason.value = false;
    } else {
      isValidReason.value = true;
    }
  }

  getDateRange(List<DateTime?> dateRange) {
    if (dateRange.length < 2) {
      return;
    }
    DateFormat format = DateFormat("yyyy/MM/dd");

    if (dateRange[0] != null) {
      dateStart.value = format.format(dateRange[0]!);
    }

    if (dateRange[1] != null) {
      dateEnd.value = format.format(dateRange[1]!);
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
