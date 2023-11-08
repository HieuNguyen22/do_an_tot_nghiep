import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_gradient_text.dart';
import 'package:app_work_log/modules/enroll_company/controllers/enroll_company_controller.dart';
import 'package:app_work_log/modules/enroll_company/widgets/custom_google_map.dart';
import 'package:app_work_log/routes/app_pages.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetLocationView extends GetView<EnrollCompanyController> {
  const GetLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              getLocationCustom(),
              Obx(
                () => Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
                  decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.only(
                    //     topLeft: Radius.circular(30),
                    //     topRight: Radius.circular(30)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4, spreadRadius: 4, color: Colors.black12)
                    ],
                  ),
                  child: Column(
                    children: [
                      getLocationOption("assets/icons/ic_work_method.png",
                          "address".tr, controller.addressTemp.value, false),
                      getLocationOption(
                          "assets/icons/ic_work_method.png",
                          "coordinates".tr,
                          "${controller.currentPositionTemp.value.lat}, ${controller.currentPositionTemp.value.lng}",
                          false),
                      getLocationOption("assets/icons/ic_work_method.png",
                          "maximum_check-in_distance".tr, "50", true),
                      SizedBox(
                        height: 5,
                      ),
                      getSaveButton()
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 15,
            left: 20,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4, spreadRadius: 4, color: Colors.black12)
                  ],
                ),
                child: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ),
          Positioned(
            top: 70,
            left: Numeral.WIDTH_SCREEN * 0.1,
            right: Numeral.WIDTH_SCREEN * 0.1,
            child: Container(
                width: Numeral.WIDTH_SCREEN * 0.8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12, spreadRadius: 2, blurRadius: 4)
                    ]),
                child: TextFormField(
                  controller: controller.textSearchLocation,
                  onChanged: (value) {
                    // controller.getPossitionFromAddress();
                  },
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                          left: 15, bottom: 13, top: 13, right: 15),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: InkWell(
                          onTap: () {
                            controller.getPossitionFromAddressCustom();
                          },
                          child: const Icon(Icons.arrow_forward)),
                      hintStyle:
                          TextStyle(color: AppColor.primaryGrey, fontSize: 14),
                      hintText: "Your location"),
                )),
          )
        ],
      ),
    ));
  }

  getSaveButton() {
    return GestureDetector(
      onTap: () {
        controller.saveLocation();
        Get.back();
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
    );
  }

  getLocationCustom() {
    return Expanded(
      child: CustomGoogleMap(
        customGoogleMapController: controller.customGoogleMapController,
        initialPosition: controller.currentPosition.value,
        onUpdateAddress: controller.onUpdateAddress,
      ),
    );
  }

  getLocationOption(
      String imagePath, String label, String description, bool isEditable) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Image.asset(
            imagePath,
            width: 22,
            height: 22,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0),
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
                (!isEditable)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          description,
                          style: TextStyle(
                              color: AppColor.primaryGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    : TextField(
                        controller: controller.maxDistanceController.value,
                        cursorColor: AppColor.primaryPurple,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Radius",
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.primaryPurple),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColor.primaryPurple),
                          ),
                        ),
                        obscureText: false,
                      ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        )
      ],
    );
  }
}
