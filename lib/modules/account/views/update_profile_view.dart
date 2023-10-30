import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_appbar.dart';
import 'package:attendance_fast/common/widgets/base_button_login.dart';
import 'package:attendance_fast/common/widgets/base_gradient_text.dart';
import 'package:attendance_fast/common/widgets/base_text_form_field.dart';
import 'package:attendance_fast/modules/account/controllers/update_profile_controller.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BaseAppBar(
                    title: "",
                    action: SizedBox(),
                    hasBack: true,
                  ),
                  getTitleWidget(),
                  SizedBox(height: Get.height * 0.03),
                  getFormWidget(),
                  SizedBox(height: Get.height * 0.03),
                  getButton()
                ],
              ),
            ),
          )),
    );
  }

  getButton() {
    return Padding(
        padding: EdgeInsets.only(bottom: Get.height * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => controller.validateAndCallApi(),
              child: BaseButtonLogin(
                height: Get.height * 0.06,
                width: Numeral.WIDTH_SCREEN * 0.4,
                title: "save".tr,
                borderRadius: 14,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () => controller.resetInputField(),
              child: BaseButtonLogin(
                height: Get.height * 0.06,
                width: Numeral.WIDTH_SCREEN * 0.4,
                title: "clear".tr,
                borderRadius: 14,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                widthBorder: 1.5,
                colorBegin: Colors.white,
                colorEnd: Colors.white,
                textColor: AppColor.primaryBlue,
              ),
            ),
          ],
        ));
  }

  getFormWidget() {
    return Form(
      key: controller.formKeyCreateStaff,
      child: Column(children: [
        getInputWidget(),
        const SizedBox(height: 18),
      ]),
    );
  }

  getInputWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                prefixIcon: Icon(Icons.apartment_rounded,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: "company_name".tr,
                enabled: false,
                controller: controller.textCompanyName,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                prefixIcon: Icon(Icons.email,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'email'.tr,
                enabled: false,
                controller: controller.textEmail,
                validateFunction: controller.emailValidateFunc,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                prefixIcon: Icon(Icons.badge,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'status'.tr,
                textColor: AppColor.primaryGreen,
                controller: controller.textStatusCode,
                enabled: false,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                prefixIcon: Icon(Icons.person,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'first_name'.tr,
                controller: controller.textFirstName,
                validateFunction: controller.emptyValidateFunc,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                prefixIcon: Icon(Icons.person,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'last_name'.tr,
                controller: controller.textLastName,
                validateFunction: controller.emptyValidateFunc,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                prefixIcon: Icon(Icons.badge,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'employee_id'.tr,
                controller: controller.textEmployeeID,
                validateFunction: controller.emptyValidateFunc,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                prefixIcon: Icon(Icons.import_contacts,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'address'.tr,
                controller: controller.textAddress,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              BaseTextFormField(
                prefixIcon: Icon(Icons.call,
                    color: AppColor.primaryGrey.withOpacity(0.8)),
                label: 'phone_number'.tr,
                textInputType: TextInputType.phone,
                controller: controller.textPhoneNumber,
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
          'update'.tr,
          style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w600),
          gradient: LinearGradient(colors: [
            AppColor.primaryBlue,
            AppColor.primaryPurple,
          ]),
        ),
        Text(
          "update_your_profile".tr,
          style: TextStyle(
              color: AppColor.primaryGrey,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
