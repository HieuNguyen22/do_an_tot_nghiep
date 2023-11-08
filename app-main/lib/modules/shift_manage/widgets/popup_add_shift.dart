import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/common/widgets/base_text_form_field.dart';
import 'package:app_work_log/modules/shift_manage/controllers/shift_manage_controller.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PopupAddShift extends GetView<ShiftManageController> {
  const PopupAddShift({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Container(
        padding: EdgeInsets.all(Numeral.WIDTH_SCREEN * 0.025),
        height: Get.height * 0.45,
        width: Numeral.WIDTH_SCREEN,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: Numeral.WIDTH_SCREEN,
                    margin: EdgeInsets.only(top: Get.height * 0.025),
                    child: BaseText(
                      text: "shift_manage".tr,
                      isTile: true,
                      size: 18,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Get.height * 0.025),
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.close)),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    top: Get.height * 0.05,
                    right: Numeral.WIDTH_SCREEN * 0.05,
                    left: Numeral.WIDTH_SCREEN * 0.05),
                decoration: BoxDecoration(
                    color: AppColor.lightPurple,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12, spreadRadius: 2, blurRadius: 4)
                    ]),
                child: Column(
                  children: [
                    BaseTextFormField(
                      controller: controller.textShift.value,
                      prefixIcon: Container(
                          margin: EdgeInsets.all(Numeral.WIDTH_SCREEN * 0.04),
                          child: SvgPicture.asset(
                              "assets/images/manage/ic_shift_textfield.svg")),
                      label: "shift".tr,
                      validateFunction: controller.emptyValidateFunc,
                    ),
                    const Divider(),
                    Container(
                      margin: EdgeInsets.only(
                        left: Numeral.WIDTH_SCREEN * 0.025,
                        right: Numeral.WIDTH_SCREEN * 0.025,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getTimePickerWidget("begin".tr, controller.timeStart),
                          getTimePickerWidget("end".tr, controller.timeEnd),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  controller.validateAdd();
                },
                child: Container(
                  margin: EdgeInsets.only(top: Get.height * 0.0125),
                  child: Center(
                    child: BaseButton(
                      height: Get.height * 0.06,
                      width: Numeral.WIDTH_SCREEN * 0.4,
                      title: "save".tr,
                      iconLeft: SizedBox(
                        height: Numeral.WIDTH_SCREEN * 0.06,
                        width: Numeral.WIDTH_SCREEN * 0.06,
                        child: SvgPicture.asset("assets/images/manage/ic_add_border.svg")),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getTimePickerWidget(String label, RxString chosenTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: BaseText(
            text: label,
            size: 17,
            isTile: false,
            colorText: AppColor.primaryGrey,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.of(Get.context!).push(
              showPicker(
                context: Get.context,
                value: Time(
                    hour: DateTime.now().hour, minute: DateTime.now().minute),
                minuteInterval: TimePickerInterval.FIVE,
                is24HrFormat: false,
                iosStylePicker: true,
                sunrise: TimeOfDay(hour: 6, minute: 0), // optional
                sunset: TimeOfDay(hour: 18, minute: 0), // optional
                duskSpanInMinutes: 120, // optional
                onChange: (time) {
                  chosenTime.value = "${time.hour}:${time.minute}";
                },
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14),
            width: Numeral.WIDTH_SCREEN * 0.35,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.primaryGrey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.schedule,
                  size: 18,
                  color: AppColor.primaryGrey,
                ),
                SizedBox(width: 10),
                Obx(
                  () => BaseText(
                    text: chosenTime.value,
                    size: 16,
                    colorText: AppColor.primaryBlue,
                    isTile: true,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
