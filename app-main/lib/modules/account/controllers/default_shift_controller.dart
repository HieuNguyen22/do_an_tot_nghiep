import 'package:app_work_log/modules/account/models/shift_model.dart';
import 'package:app_work_log/modules/account/provider/default_shift_provider.dart';
import 'package:app_work_log/modules/home/controllers/home_controller.dart';
import 'package:app_work_log/modules/home/models/user_model.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

class DefaultShiftController extends GetxController {
  var listShift = <ShiftManager>[ShiftManager(id: -1)].obs;
  var selectDefaultShift = 0.obs;
  var userInfo = UserModel().obs;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    getListShift();
  }

  getUserInfo() async {
    var result = await DefaultShiftProvider().getUserInfo();
    userInfo.value = result;
  }

  resetList() {
    listShift.value = [ShiftManager(id: -1)];
  }

  selectShift(int shift){
    selectDefaultShift.value = shift;
  }

  getListShift() async {
    resetList();
    listShift.value =
        await DefaultShiftProvider().getListShiftofCompanyUserLogin();
    listShift.insert(0, ShiftManager());
    setSelectDefaultShift();
  }

  setSelectDefaultShift() {
    if (userInfo.value.shiftId == null) {
      selectDefaultShift.value = 0;
    } else {
      selectDefaultShift.value =
          listShift.indexWhere((item) => item.id == userInfo.value.shiftId);
    }
  }

  saveDefaultShift() async {
    var result = await DefaultShiftProvider()
        .updateDefaultShift(shiftId: listShift[selectDefaultShift.value].id);
    if (result) {
      Get.find<HomeController>().callApiUserProvider();
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
        onDismissCallback: (type) {
          Get.back();
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
}
