import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/modules/account/provider/default_checkin_provider.dart';
import 'package:app_work_log/modules/home/controllers/home_controller.dart';
import 'package:app_work_log/modules/home/models/user_model.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';

class DefaultCheckinController extends GetxController {
  var userInfo = UserModel().obs;
  var selectDefaultCheckin = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }

  getUserInfo() async {
    var result = await DefaultCheckinProvider().getUserInfo();
    userInfo.value = result;
    if (userInfo.value.typeLogin == null) {
      selectDefaultCheckin.value =
          userInfo.value.companyInfo!.typeCheckLogin! ==
                  Numeral.TYPE_CHECKIN_LOCATION_WIFI
              ? Numeral.TYPE_CHECKIN_LOCATION
              : userInfo.value.companyInfo!.typeCheckLogin!;
    } else if(userInfo.value.typeLogin != userInfo.value.companyInfo!.typeCheckLogin! && userInfo.value.companyInfo!.typeCheckLogin! != Numeral.TYPE_CHECKIN_LOCATION_WIFI){
      selectDefaultCheckin.value = userInfo.value.companyInfo!.typeCheckLogin!;
      var result = await DefaultCheckinProvider()
        .updateDefaultCheckin(typeCheckin: selectDefaultCheckin.value);
    } else {
      selectDefaultCheckin.value = userInfo.value.typeLogin;
    }
  }

  selectTypeCheckin(int typeCheckin) {
    if (userInfo.value.companyInfo!.typeCheckLogin! ==
        Numeral.TYPE_CHECKIN_LOCATION_WIFI){
          selectDefaultCheckin.value = typeCheckin;
        } else {
          String typeCheckin = userInfo.value.companyInfo!.typeCheckLogin! == Numeral.TYPE_CHECKIN_LOCATION ? "location".tr.toLowerCase() : "wifi".tr.toLowerCase();
          Get.snackbar("noti".tr, "noti_default_checkin".trParams({
            "typeCheckin": typeCheckin
          }));
        }
      
  }

  saveDefaultCheckin() async {
    var result = await DefaultCheckinProvider()
        .updateDefaultCheckin(typeCheckin: selectDefaultCheckin.value);
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
