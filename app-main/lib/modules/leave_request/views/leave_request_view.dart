import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_appbar.dart';
import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/common/widgets/base_text_form_field.dart';
import 'package:app_work_log/modules/leave_request/controllers/leave_request_controller.dart';
import 'package:app_work_log/modules/leave_request/models/manager_model.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LeaveRequestView extends GetView<LeaveRequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: Numeral.WIDTH_SCREEN,
          height: Get.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/common/img_bg_3.png"),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.only(
                top: Get.height * 0.04,
                right: Numeral.WIDTH_SCREEN * 0.03,
                left: Numeral.WIDTH_SCREEN * 0.03),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  BaseAppBar(
                    title: "casual_leave".tr,
                    action: const SizedBox(),
                    hasBack: true,
                    titleStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: AppColor.primaryText),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          getManagerWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                          getChooseTimeWidget(),
                          const SizedBox(
                            height: 20,
                          ),
                          getReasonWidget(),
                          const SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.submit();
                            },
                            child: BaseButton(
                              height: Get.height * 0.065,
                              width: Numeral.WIDTH_SCREEN * 0.6,
                              title: "submit_for_approval".tr,
                              fontSize: 16,
                              textColor: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                        ],
                      ),
                    ),
                  ),
                  (MediaQuery.of(context).viewInsets.bottom != 0)
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).viewInsets.bottom)
                              : const SizedBox()
                ],
              ),
            ),
          )),
    );
  }

  getReasonWidget() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "reason".tr,
            style: TextStyle(
                color: AppColor.primaryGrey,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: Numeral.WIDTH_SCREEN * 0.8,
            height: Get.height * 0.2,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            decoration: BoxDecoration(
                color: AppColor.lightPurple,
                borderRadius: BorderRadius.circular(12),
                border: (!controller.isValidReason.value)
                    ? Border.all(color: AppColor.lightRed, width: 1.5)
                    : null,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 2, blurRadius: 4)
                ]),
            child: TextField(
              maxLength: 500,
              maxLines: null,
              controller: controller.reasonController,
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                      color: (controller.isValidReason.value)
                          ? AppColor.primaryGrey
                          : AppColor.lightRed),
                  border: InputBorder.none,
                  hintText: "reason".tr),
            ),
          )
        ],
      ),
    );
  }

  getChooseTimeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "choose_time".tr,
          style: TextStyle(
              color: AppColor.primaryGrey,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 12,
        ),
        Container(
          width: Numeral.WIDTH_SCREEN * 0.8,
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              color: AppColor.lightPurple,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 4)
              ]),
          child: Column(
            children: [
              Obx(
                () => Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12, top: 8),
                  child: GestureDetector(
                    onTap: () => getDateBottomSheet(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${controller.dateStart} - ${controller.dateEnd}",
                          style: TextStyle(
                              color: (controller.isValidDate.value)
                                  ? AppColor.primaryBlue
                                  : AppColor.lightRed,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                        Icon(Icons.calendar_month,
                            color: AppColor.primaryGrey.withOpacity(0.8)),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTimePickerWidget("begin".tr, controller.timeStart,
                        controller.isValidTimeStart),
                    getTimePickerWidget("end".tr, controller.timeEnd,
                        controller.isValidTimeEnd),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Divider(),
              ),
              Container(
                height: Get.height * 0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: BaseTextFormField(
                        label: 'hour'.tr,
                        textInputType: TextInputType.number,
                        controller: controller.hourTotalController,
                        validateFunction: controller.emptyValidateFunc,
                      ),
                    ),
                    const VerticalDivider(),
                    Expanded(
                      child: BaseTextFormField(
                        label: 'minute'.tr,
                        textInputType: TextInputType.number,
                        controller: controller.minuteTotalController,
                        validateFunction: controller.emptyValidateFunc,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              )
            ],
          ),
        ),
      ],
    );
  }

  getTimePickerWidget(String label, RxString chosenTime, RxBool validator) {
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
                sunrise: const TimeOfDay(hour: 6, minute: 0), // optional
                sunset: const TimeOfDay(hour: 18, minute: 0), // optional
                duskSpanInMinutes: 120, // optional
                onChange: (time) {
                  chosenTime.value = "${time.hour}:${time.minute}";
                },
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
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
                const SizedBox(width: 10),
                Obx(
                  () => BaseText(
                    text: chosenTime.value,
                    size: 16,
                    colorText: (validator.value)
                        ? AppColor.primaryBlue
                        : AppColor.lightRed,
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

  getManagerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "manager".tr,
          style: TextStyle(
              color: AppColor.primaryGrey,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 12,
        ),
        Obx(
          () => Container(
            width: Numeral.WIDTH_SCREEN * 0.8,
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: AppColor.lightPurple,
                borderRadius: BorderRadius.circular(12),
                border: (!controller.isValidManager.value)
                    ? Border.all(color: AppColor.lightRed, width: 1.5)
                    : null,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 2, blurRadius: 4)
                ]),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<ManagerModel>(
                isExpanded: true,
                hint: TextFormField(
                    cursorColor: Colors.black,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: controller.selectedDropBox.value,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                          left: 15, bottom: 13, top: 13, right: 15),
                      prefixIcon: Icon(Icons.supervisor_account,
                          color: AppColor.primaryGrey.withOpacity(0.8)),
                      labelStyle: TextStyle(
                          color: (controller.isValidManager.value)
                              ? AppColor.primaryGrey
                              : AppColor.lightRed,
                          fontSize: 14),
                    )),
                items: controller.listManager
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            "${item.name} - ${item.departName}",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.updateSelectedManager(value);
                  }
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 200,
                ),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: controller.searchDropBoxController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: controller.searchDropBoxController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for a manager...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    String displayedLabel =
                        "${item.value?.name} - ${item.value?.departName}";

                    displayedLabel = displayedLabel.toLowerCase();
                    searchValue = searchValue.toLowerCase();

                    return displayedLabel.contains(searchValue);
                  },
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    controller.searchDropBoxController.clear();
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void getDateBottomSheet() {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.teal[800],
      weekdayLabelTextStyle: const TextStyle(
          color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 17),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    );
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () => Get.back(), child: const Icon(Icons.close))
                ],
              ),
            ),
            CalendarDatePicker2(
              onValueChanged: (value) {
                controller.getDateRange(value);
              },
              config: config,
              value: [
                DateTime.now(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
