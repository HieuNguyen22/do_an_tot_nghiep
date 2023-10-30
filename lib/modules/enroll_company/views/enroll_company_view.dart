import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_appbar.dart';
import 'package:attendance_fast/common/widgets/base_button.dart';
import 'package:attendance_fast/common/widgets/base_button_login.dart';
import 'package:attendance_fast/common/widgets/base_gradient_text.dart';
import 'package:attendance_fast/common/widgets/base_text_form_field.dart';
import 'package:attendance_fast/modules/enroll_company/controllers/enroll_company_controller.dart';
import 'package:attendance_fast/routes/app_pages.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnrollCompanyView extends GetView<EnrollCompanyController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
          width: Numeral.WIDTH_SCREEN,
          height: Get.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/common/img_bg_2.png"),
                  fit: BoxFit.fill)),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: Get.height * 0.04,
                    right: Numeral.WIDTH_SCREEN * 0.03,
                    left: Numeral.WIDTH_SCREEN * 0.03),
                child: Column(
                  children: [
                    const BaseAppBar(
                      title: "",
                      action: SizedBox(),
                      hasBack: true,
                    ),
                    getTitleWidget(),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    getCompanyWidget(),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    getAdminWidget(),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      width: Numeral.WIDTH_SCREEN * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => GestureDetector(
                                onTap: () => controller.updatePrivacyChecking(),
                                child: Image.asset(
                                    (controller.isCheckedPrivacy.value)
                                        ? "assets/icons/ic_check_box.png"
                                        : "assets/icons/ic_uncheck_box.png",
                                    width: 22,
                                    height: 22),
                              )),
                          const SizedBox(width: 12),
                          Column(
                            children: [
                              Text('by_signing_you_agree_to_our'.tr,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.primaryGrey)),
                              GradientText(
                                'term_of_use_and_privacy'.tr,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                                gradient: LinearGradient(colors: [
                                  AppColor.primaryBlue,
                                  AppColor.primaryPurple,
                                ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.05,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: Get.height * 0.05),
                      child: GestureDetector(
                        onTap: () {
                          controller.validateAndSaveEnroll();
                        },
                        child: BaseButtonLogin(
                            height: Get.height * 0.07,
                            width: Numeral.WIDTH_SCREEN * 0.8,
                            hasArrow: true,
                            title: "sign_up".tr,
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
            ),
          )),
    );
  }

  getAdminWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "admin".tr,
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
              BaseTextFormField(
                controller: controller.firstNameController,
                prefixIcon: Icon(Icons.person,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'first_name'.tr,
                validateFunction: controller.emptyValidateFunc,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                controller: controller.lastNameController,
                prefixIcon: Icon(Icons.person,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'last_name'.tr,
                validateFunction: controller.emptyValidateFunc,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                controller: controller.employeeIdController,
                prefixIcon: Icon(Icons.person,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'employee_id'.tr,
                validateFunction: controller.emptyValidateFunc,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                controller: controller.emailController,
                prefixIcon: Icon(Icons.email,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'email'.tr,
                validateFunction: controller.emailValidateFunc,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                controller: controller.passwordController,
                prefixIcon: Icon(Icons.lock,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'password'.tr,
                validateFunction: controller.passwordValidateFunc,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                controller: controller.confirmPasswordController,
                prefixIcon: Icon(Icons.lock,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'confirm_password'.tr,
                validateFunction: controller.confirmPasswordValidateFunc,
              ),
            ],
          ),
        )
      ],
    );
  }

  getCompanyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "company".tr,
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
              BaseTextFormField(
                controller: controller.companyNameController,
                prefixIcon: Icon(Icons.apartment_rounded,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'company_name'.tr,
                validateFunction: controller.emptyValidateFunc,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                controller: controller.representativeController,
                prefixIcon: Icon(Icons.person,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'representative'.tr,
                validateFunction: controller.emptyValidateFunc,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                controller: controller.addressController,
                prefixIcon: Icon(Icons.location_on,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'address'.tr,
                validateFunction: controller.emptyValidateFunc,
              ),
            ],
          ),
        )
      ],
    );
  }

  getTitleWidget() {
    return Column(
      children: [
        GradientText(
          'sign_up'.tr,
          style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w600),
          gradient: LinearGradient(colors: [
            AppColor.primaryBlue,
            AppColor.primaryPurple,
          ]),
        ),
        Text(
          "enroll_company_desc".tr,
          style: TextStyle(
              color: AppColor.primaryGrey,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
