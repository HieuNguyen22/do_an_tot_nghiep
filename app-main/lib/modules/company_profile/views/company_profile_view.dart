import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/common/widgets/base_text_form_field.dart';
import 'package:app_work_log/modules/company_profile/controllers/company_profile_controller.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CompanyProfileView extends GetView<CompanyProfileController> {
  const CompanyProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: Get.height,
        width: Numeral.WIDTH_SCREEN,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/common/img_bg_1.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Obx(
          () => (controller.companyInfo.value.id == null)
              ? Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColor.primaryPurple),
                    ),
                  ),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: const Icon(
                                      Icons.chevron_left,
                                      size: 24,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
                          Obx(
                            () => BaseText(
                              text: controller.companyInfo.value.name,
                              isTile: true,
                              size: 20,
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(top: Get.height * 0.0125),
                          //   child: BaseText(
                          //     text: "Product Manager",
                          //     size: 18,
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: Get.height * 0.0125),
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 4,
                                      spreadRadius: 4,
                                      color: Colors.black12)
                                ]),
                            child: QrImageView(
                              data: controller.companyInfo.value.companyCode!,
                              version: QrVersions.auto,
                              size: Numeral.WIDTH_SCREEN * 0.6,
                              gapless: false,
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              controller.shareCompanyCode();
                            },
                            child: Container(
                               margin: EdgeInsets.only(top: Get.height * 0.01),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.share,
                                    color: AppColor.primaryBlue,
                                  ),
                                  SizedBox(width: Get.width * 0.0125,),
                                  BaseText(
                                    text: "Share",
                                    isTile: true,
                                    size: 20,
                                    colorText: AppColor.primaryBlue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InputInfoCompany(),
                          InputInfoAdmin(),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget InputInfoCompany() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: Numeral.WIDTH_SCREEN * 0.05,
              right: Numeral.WIDTH_SCREEN * 0.05,
              top: Get.height * 0.025),
          child: Row(
            children: [
              BaseText(
                text: "company".tr,
                size: 16,
              ),
              Expanded(
                child: Container(),
              ),
              Obx(
                () => !controller.editCompany.value
                    ? InkWell(
                        onTap: () {
                          controller.editCompany.value =
                              !controller.editCompany.value;
                        },
                        child: SvgPicture.asset(
                            "assets/images/common/ic_edit_profile.svg"),
                      )
                    : Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.editCompany.toggle();
                            },
                            child: Icon(
                              Icons.close,
                              color: AppColor.lightRed,
                            ),
                          ),
                          SizedBox(
                            width: Numeral.WIDTH_SCREEN * 0.025,
                          ),
                          InkWell(
                            onTap: () async {
                              if (await controller.validateUpdate()) {
                                {
                                  controller.editCompany.toggle();
                                  controller.saveInfoCompany();
                                }
                              }
                            },
                            child: Icon(
                              Icons.check,
                              color: AppColor.primaryGreen,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: Numeral.WIDTH_SCREEN * 0.05,
              right: Numeral.WIDTH_SCREEN * 0.05,
              top: Get.height * 0.0125),
          decoration: BoxDecoration(
              color: AppColor.lightPurple,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
              ]),
          child: Obx(
            () => Column(
              children: [
                BaseTextFormField(
                  controller: controller.textCompanyName.value,
                  prefixIcon: Icon(Icons.diversity_3_sharp,
                      color: AppColor.primaryGrey.withOpacity(0.8)),
                  label: "company_name".tr,
                  enabled: controller.editCompany.value,
                  validateFunction: controller.emptyValidateFunc,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Numeral.WIDTH_SCREEN * 0.025,
                    right: Numeral.WIDTH_SCREEN * 0.025,
                  ),
                  child: Divider(),
                ),
                BaseTextFormField(
                  controller: controller.textRepresentative.value,
                  prefixIcon: Icon(Icons.person,
                      color: AppColor.primaryGrey.withOpacity(0.8)),
                  label: 'representative'.tr,
                  enabled: controller.editCompany.value,
                  validateFunction: controller.emptyValidateFunc,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Numeral.WIDTH_SCREEN * 0.025,
                    right: Numeral.WIDTH_SCREEN * 0.025,
                  ),
                  child: Divider(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: BaseTextFormField(
                        controller: controller.textCode.value,
                        prefixIcon: Icon(Icons.code,
                            color: AppColor.primaryGrey.withOpacity(0.8)),
                        label: 'code'.tr,
                        enabled: false,
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(
                            text: controller.textCode.value.text));
                        Fluttertoast.showToast(
                            msg: "copied_clipboard".tr,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColor.lightPurple,
                            textColor: Colors.black,
                            fontSize: 16.0);
                      },
                      child: Icon(
                        Icons.content_copy,
                        color: AppColor.primaryGrey.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(
                      width: Numeral.WIDTH_SCREEN * 0.025,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget InputInfoAdmin() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: Numeral.WIDTH_SCREEN * 0.05,
              right: Numeral.WIDTH_SCREEN * 0.05,
              top: Get.height * 0.025),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseText(
                text: "admin".tr,
                size: 16,
              ),
              Obx(
                () => !controller.editAdmin.value
                    ? InkWell(
                        onTap: () {
                          controller.editAdmin.toggle();
                        },
                        child: SvgPicture.asset(
                            "assets/images/common/ic_edit_profile.svg"),
                      )
                    : Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.editAdmin.value =
                                  !controller.editAdmin.value;
                            },
                            child: Icon(
                              Icons.close,
                              color: AppColor.lightRed,
                            ),
                          ),
                          SizedBox(
                            width: Numeral.WIDTH_SCREEN * 0.025,
                          ),
                          InkWell(
                            onTap: () {
                              controller.editAdmin.toggle();
                              controller.saveInfoCompany();
                            },
                            child: Icon(
                              Icons.check,
                              color: AppColor.primaryGreen,
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              left: Numeral.WIDTH_SCREEN * 0.05,
              right: Numeral.WIDTH_SCREEN * 0.05,
              top: Get.height * 0.0125),
          decoration: BoxDecoration(
              color: AppColor.lightPurple,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
              ]),
          child: Obx(
            () => Column(
              children: [
                BaseTextFormField(
                    controller: controller.textEmail.value,
                    prefixIcon: Icon(Icons.email,
                        color: AppColor.primaryGrey.withOpacity(0.8)),
                    label: "email".tr,
                    enabled: false),
                Container(
                  margin: EdgeInsets.only(
                    left: Numeral.WIDTH_SCREEN * 0.025,
                    right: Numeral.WIDTH_SCREEN * 0.025,
                  ),
                  child: Divider(),
                ),
                BaseTextFormField(
                  controller: controller.textPhoneNumber.value,
                  prefixIcon: Icon(Icons.phone,
                      color: AppColor.primaryGrey.withOpacity(0.8)),
                  label: 'phone_number'.tr,
                  enabled: controller.editAdmin.value,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Numeral.WIDTH_SCREEN * 0.025,
                    right: Numeral.WIDTH_SCREEN * 0.025,
                  ),
                  child: Divider(),
                ),
                BaseTextFormField(
                  controller: controller.textField.value,
                  prefixIcon: Icon(Icons.lock,
                      color: AppColor.primaryGrey.withOpacity(0.8)),
                  label: 'field'.tr,
                  enabled: controller.editAdmin.value,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: Numeral.WIDTH_SCREEN * 0.025,
                    right: Numeral.WIDTH_SCREEN * 0.025,
                  ),
                  child: Divider(),
                ),
                BaseTextFormField(
                  controller: controller.textNumberWorkes.value,
                  prefixIcon: Icon(Icons.person,
                      color: AppColor.primaryGrey.withOpacity(0.8)),
                  label: 'number_workers'.tr,
                  enabled: false,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.025,
        ),
      ],
    );
  }
}
