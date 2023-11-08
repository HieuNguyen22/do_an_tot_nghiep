import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_appbar.dart';
import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_gradient_text.dart';
import 'package:app_work_log/modules/enroll_company/controllers/enroll_company_controller.dart';
import 'package:app_work_log/routes/app_pages.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EnrollSuccessView extends GetView<EnrollCompanyController> {
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
                  Icon(Icons.check_circle,
                      size: 80, color: AppColor.primaryGreen),
                  SizedBox(height: Get.height * 0.012),
                  getTitleWidget(),
                  SizedBox(height: Get.height * 0.03),
                  getCompanyIdWidget(),
                  SizedBox(height: Get.height * 0.03),
                  getSetupCompanyWidget(),
                  SizedBox(height: Get.height * 0.03),
                  getTutorialWidget(),
                  SizedBox(height: Get.height * 0.05),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: GestureDetector(
                      onTap: () => Get.offAllNamed(Routes.HOME),
                      child: BaseButton(
                        height: Get.height * 0.08,
                        width: Numeral.WIDTH_SCREEN,
                        title: "go_to_home".tr,
                        textColor: Colors.white,
                        fontSize: 20,
                        verticalPadding: 14,
                        horizontalPadding: 10,
                        colorBegin: AppColor.primaryBlue.withOpacity(0.9),
                        colorEnd: AppColor.primaryPurple.withOpacity(0.9),
                        fontWeight: FontWeight.w600,
                        borderRadius: 10,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  getTitleWidget() {
    return Column(
      children: [
        GradientText(
          'your_company_has_been_created'.tr,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          gradient: LinearGradient(colors: [
            AppColor.primaryBlue,
            AppColor.primaryPurple,
          ]),
        ),
      ],
    );
  }

  getCompanyIdWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          SizedBox(
            child: Text(
              "enroll_success_share_id".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.primaryGrey,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: Get.height * 0.03),
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 4, spreadRadius: 4, color: Colors.black12)
                ]),
            child: QrImageView(
              data: controller.codeCompanySignUpSuccess.value,
              version: QrVersions.auto,
              size: Numeral.WIDTH_SCREEN * 0.6,
              gapless: false,
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: controller.codeCompanySignUpSuccess.value));
              Fluttertoast.showToast(
                  msg: "copied_clipboard".tr,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColor.lightPurple,
                  textColor: Colors.black,
                  fontSize: 16.0);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientText(
                  '#${controller.codeCompanySignUpSuccess.value}',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700),
                  gradient: LinearGradient(colors: [
                    AppColor.primaryBlue,
                    AppColor.primaryPurple,
                  ]),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.content_copy, size: 18)
              ],
            ),
          )
        ],
      ),
    );
  }

  getSetupCompanyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          Text(
            "enroll_success_setup".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.primaryGrey,
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: Get.height * 0.03),
          InkWell(
            onTap: (){
              Get.toNamed(Routes.SHIFT_MANAGE);
            },
            child: getSetupButton("assets/images/manage/ic_shift.svg", "manage_shift".tr,
                AppColor.colorCardManageShift),
          ),
          SizedBox(height: Get.height * 0.03),
          InkWell(
            onTap: (){
              Get.toNamed(Routes.DEPARTMENT_MANAGE);
            },
            child: getSetupButton("assets/images/manage/ic_department.svg",
                "manage_department".tr, AppColor.colorCardManageDepartment),
          )
        ],
      ),
    );
  }

  getTutorialWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        children: [
          Text(
            "enroll_success_video_tutorial".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.primaryGrey,
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: Get.height * 0.03),
          Text(
            "https://www.youtube.com/watch?v=ddp1jwkDwr8&ab_channel=azamsharp",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.lightBlue,
              fontSize: 17,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget getSetupButton(String imagePath, String label, Color color) {
    return Container(
      width: Numeral.WIDTH_SCREEN * 0.7,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(blurRadius: 4, spreadRadius: 4, color: Colors.black12)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Numeral.WIDTH_SCREEN / 7,
            height: Numeral.WIDTH_SCREEN / 7,
            decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: SvgPicture.asset(imagePath,
                height: Numeral.WIDTH_SCREEN / 8,
                width: Numeral.WIDTH_SCREEN / 8,
                fit: BoxFit.scaleDown),
          ),
          SizedBox(
            width: Numeral.WIDTH_SCREEN * 0.3,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.primaryGrey,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 19,
            ),
          )
        ],
      ),
    );
  }
}
