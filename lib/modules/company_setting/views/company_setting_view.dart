import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_appbar.dart';
import 'package:attendance_fast/common/widgets/base_button.dart';
import 'package:attendance_fast/common/widgets/base_button_login.dart';
import 'package:attendance_fast/common/widgets/base_gradient_text.dart';
import 'package:attendance_fast/modules/company_setting/controllers/company_setting_controller.dart';
import 'package:attendance_fast/modules/home/controllers/home_controller.dart';
import 'package:attendance_fast/routes/app_pages.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CompanySettingView extends GetView<CompanySettingController> {
  const CompanySettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: Numeral.WIDTH_SCREEN,
          height: Get.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/common/img_bg_2.png"),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.only(
                top: Get.height * 0.04,
                right: Numeral.WIDTH_SCREEN * 0.03,
                left: Numeral.WIDTH_SCREEN * 0.03),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const BaseAppBar(
                    title: "",
                    action: SizedBox(),
                    hasBack: true,
                  ),
                  getTitleWidget(),
                  const SizedBox(height: 14),
                  getMethodWidget(),
                  const SizedBox(height: 14),
                  Visibility(
                    visible: !kIsWeb,
                    child: getLocationWidget(),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (await controller.updateSettingCompany()) {
                          await Get.find<HomeController>().callApiUserProvider();
                          AwesomeDialog(
                            context: Get.context!,
                            dialogType: DialogType.success,
                            animType: AnimType.scale,
                            title: "success".tr,
                            desc: "success".tr,
                            btnOkColor: AppColor.primaryGreen,
                            btnOkOnPress: () {
                              Get.back();
                            },
                            onDismissCallback: (type) {
                              Get.back();
                            },
                          ).show();
                        }
                      },
                      child: BaseButton(
                          height: Get.height * 0.07,
                          width: Numeral.WIDTH_SCREEN * 0.85,
                          title: "save".tr,
                          textColor: Colors.white,
                          fontSize: 20,
                          verticalPadding: 14,
                          horizontalPadding: 10,
                          colorBegin: AppColor.primaryBlue.withOpacity(0.9),
                          colorEnd: AppColor.primaryPurple.withOpacity(0.9),
                          fontWeight: FontWeight.w600,
                          borderRadius: 10),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget getLocationWidget() {
    return GestureDetector(
      onTap: () {
        controller.textSearchLocation.text = "";
        Get.toNamed(Routes.COMPANY_LOCATION);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "location".tr,
            style: TextStyle(
                color: AppColor.primaryGrey,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: Numeral.WIDTH_SCREEN * 0.85,
            decoration: BoxDecoration(
                color: AppColor.lightPurple,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 2, blurRadius: 4)
                ]),
            child: Stack(
              children: [
                SizedBox(
                  height: Get.height * 0.25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Obx(
                      () => GoogleMap(
                        onMapCreated: (GoogleMapController ggcontroller) {
                          controller.onMapCreated(ggcontroller);
                          controller.getPosition();
                        },
                        markers: Set<Marker>.of(controller.listMarker),
                        compassEnabled: false,
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(controller.currentPosition.value.lat,
                              controller.currentPosition.value.lng),
                          zoom: Numeral.ZOOM_GOOGLE_MAP,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: BaseButtonLogin(
                    height: Get.height * 0.06,
                    width: Numeral.WIDTH_SCREEN * 0.4,
                    title: "",
                    borderRadius: 14,
                    widthBorder: 1.5,
                    colorBegin: Colors.white.withOpacity(0.3),
                    colorEnd: Colors.white.withOpacity(0.3),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: BaseButtonLogin(
                      height: Get.height * 0.06,
                      width: Numeral.WIDTH_SCREEN * 0.4,
                      title: "choose_your_location".tr,
                      borderRadius: 14,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      widthBorder: 1.5,
                      colorBegin: Colors.white,
                      colorEnd: Colors.white,
                      textColor: AppColor.primaryBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Obx(
            () => SizedBox(
              width: Numeral.WIDTH_SCREEN * 0.85,
              child: Text(
                controller.address.value,
                style: TextStyle(
                    color: AppColor.primaryGrey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getMethodOption(String imagePath, String label, String description,
      String option1, String option2, String type) {
    if (type == "checkin") {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset(
              imagePath,
              width: 22,
              height: 22,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientText(
                  label.tr,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                  gradient: LinearGradient(colors: [
                    AppColor.primaryBlue,
                    AppColor.primaryPurple,
                  ]),
                ),
                const SizedBox(height: 4),
                Text(
                  description.tr,
                  style: TextStyle(color: AppColor.primaryGrey, fontSize: 13),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => GestureDetector(
                            onTap: () => controller.updateLocationChecking(),
                            child: Icon(
                                (controller.isCheckedLocation.value)
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                size: 20,
                                color: AppColor.primaryGrey),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          option1.tr,
                          style: TextStyle(
                              color: AppColor.primaryGrey,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: Numeral.WIDTH_SCREEN * 0.1),
                      child: Row(
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () => controller.updateWifiChecking(),
                              child: Icon(
                                  (controller.isCheckedWifi.value)
                                      ? Icons.check_circle
                                      : Icons.check_circle_outline,
                                  size: 20,
                                  color: AppColor.primaryGrey),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            option2.tr,
                            style: TextStyle(
                                color: AppColor.primaryGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset(
              imagePath,
              width: 22,
              height: 22,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientText(
                  label.tr,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                  gradient: LinearGradient(colors: [
                    AppColor.primaryBlue,
                    AppColor.primaryPurple,
                  ]),
                ),
                const SizedBox(height: 4),
                Text(
                  description.tr,
                  style: TextStyle(color: AppColor.primaryGrey, fontSize: 13),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => GestureDetector(
                            onTap: () => controller.updateAtWorkChecking(),
                            child: Icon(
                                (controller.isCheckedAtWork.value)
                                    ? Icons.check_circle
                                    : Icons.check_circle_outline,
                                size: 20,
                                color: AppColor.primaryGrey),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          option1.tr,
                          style: TextStyle(
                              color: AppColor.primaryGrey,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: Numeral.WIDTH_SCREEN * 0.1),
                      child: Row(
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () => controller.updateRemoteChecking(),
                              child: Icon(
                                  (controller.isCheckedRemote.value)
                                      ? Icons.check_circle
                                      : Icons.check_circle_outline,
                                  size: 20,
                                  color: AppColor.primaryGrey),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            option2.tr,
                            style: TextStyle(
                                color: AppColor.primaryGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      );
    }
  }

  getMethodWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "method".tr,
          style: TextStyle(
              color: AppColor.primaryGrey,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          width: Numeral.WIDTH_SCREEN * 0.85,
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
              color: AppColor.lightPurple,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
              ]),
          child: Column(
            children: [
              getMethodOption(
                  "assets/icons/ic_check_in_method.png",
                  "check_in".tr,
                  "check_in_desc".tr,
                  "location".tr,
                  "wifi".tr,
                  "checkin"),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              getMethodOption("assets/icons/ic_work_method.png", "work".tr,
                  "work_desc".tr, "at_work".tr, "remote".tr, "work"),
            ],
          ),
        )
      ],
    );
  }

  getTitleWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GradientText(
          'settings_company'.tr,
          style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w600),
          gradient: LinearGradient(colors: [
            AppColor.primaryBlue,
            AppColor.primaryPurple,
          ]),
        ),
        const SizedBox(height: 7),
        Container(
          width: Numeral.WIDTH_SCREEN * 0.6,
          child: Text(
            "settings_company_desc".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.primaryGrey,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
