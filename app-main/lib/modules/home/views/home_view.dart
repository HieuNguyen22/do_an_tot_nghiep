import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_button_login.dart';
import 'package:app_work_log/common/widgets/base_card_statistics.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/home/models/card_statistic_model.dart';
import 'package:app_work_log/routes/app_pages.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:app_work_log/modules/home/controllers/home_controller.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:avatar_glow/avatar_glow.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        color: AppColor.primaryPurple,
        onRefresh: () {
          return Future.delayed(
            const Duration(milliseconds: 500),
            () {
              controller.refreshData();
            },
          );
        },
        child: Container(
            width: Numeral.WIDTH_SCREEN,
            height: Get.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/common/img_bg_3.png"),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.02,
                  right: Numeral.WIDTH_SCREEN * 0.03,
                  left: Numeral.WIDTH_SCREEN * 0.03),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    getNameCompany(),
                    getCheckInWidget(context),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    getAttendanceWidget(),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 20,
                          ),
                          BaseText(
                            text: "${"location".tr}:   ",
                            size: 15,
                            isTile: true,
                            colorText: AppColor.primaryText,
                          ),
                          Obx(
                            () => Expanded(
                              child: Container(
                                child: BaseText(
                                  text: controller.address.toString(),
                                  centerText: TextAlign.start,
                                  size: 15,
                                  isTile: true,
                                  colorText: AppColor.primaryText,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    getStatisticWidget()
                  ],
                ),
              ),
            )),
      ),
    );
  }

  getNameCompany() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Numeral.WIDTH_SCREEN * 0.06,
        ),
        Obx(
          () => BaseText(
            text: controller.userInfo.value.companyInfo?.name,
            isTile: true,
            size: 15,
            colorText: AppColor.primaryGrey,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(7),
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 4, spreadRadius: 4, color: Colors.black12)
              ]),
          child: Image.asset(
            "assets/icons/ic_logo_white_bg.png",
            width: Numeral.WIDTH_SCREEN * 0.06,
            fit: BoxFit.fitWidth,
          ),
        )
      ],
    );
  }

  getCheckInWidget(BuildContext context) {
    return Column(
      children: [
        DigitalClock(
          showSecondsDigit: false,
          hourMinuteDigitTextStyle: TextStyle(
              color: AppColor.primaryText,
              fontSize: 42,
              fontWeight: FontWeight.w500),
          colon: Text(
            ":",
            style: TextStyle(
                color: AppColor.primaryText,
                fontSize: 42,
                fontWeight: FontWeight.w400),
          ),
        ),
        Obx(
          () => BaseText(
            text: controller.date.value,
            isTile: false,
            size: 15,
            colorText: AppColor.lightGrey,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Obx(
          () => InkWell(
            onTap: () {
              if (controller.userInfo.value.typeLogin ==
                      Numeral.TYPE_CHECKIN_LOCATION &&
                  controller.userInfo.value.companyInfo!.typeCheckLogin! !=
                      Numeral.TYPE_CHECKIN_WIFI) {
                controller.updateCheckInStatus();
              } else if (controller.userInfo.value.typeLogin ==
                      Numeral.TYPE_CHECKIN_WIFI &&
                  controller.userInfo.value.companyInfo!.typeCheckLogin! !=
                      Numeral.TYPE_CHECKIN_LOCATION) {
                controller.updateCheckInStatusWifi();
              } else {
                Get.toNamed(Routes.DEFAULT_CHECKIN);
              }
            },
            child: AvatarGlow(
              endRadius: Numeral.WIDTH_SCREEN * 0.3,
              glowColor: controller.checkInStatus.value == 2
                  ? AppColor.primaryGreen
                  : AppColor.primaryPink,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: const Duration(milliseconds: 100),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  controller.checkInStatus.value == 2
                      ? 'assets/images/common/img_checkin_button.png'
                      : 'assets/images/common/img_checkout_button.png',
                ),
                radius: Numeral.WIDTH_SCREEN * 0.2,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BaseText(
              text: "${"current_shift".tr}:   ",
              size: 15,
              isTile: true,
              colorText: AppColor.primaryText,
            ),
            Obx(
              () => BaseText(
                text: controller.getCurrentShiftInfo(),
                size: 15,
                isTile: true,
                colorText: AppColor.primaryText,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(Routes.LEAVE_REQUEST),
              child: BaseButtonLogin(
                height: Get.height * 0.06,
                width: Numeral.WIDTH_SCREEN * 0.4,
                title: "casual_leave".tr,
                borderRadius: 14,
                fontSize: 15,
                icon: SvgPicture.asset("assets/icons/ic_moon.svg"),
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.OVERTIME_REQUEST),
              child: BaseButtonLogin(
                height: Get.height * 0.06,
                width: Numeral.WIDTH_SCREEN * 0.4,
                title: "overtime".tr,
                borderRadius: 14,
                fontSize: 15,
                icon: SvgPicture.asset("assets/icons/ic_overtime.svg",
                    color: AppColor.primaryBlue),
                fontWeight: FontWeight.w700,
                widthBorder: 1.5,
                colorBegin: Colors.white,
                colorEnd: Colors.white,
                textColor: AppColor.primaryBlue,
              ),
            ),
          ],
        )
      ],
    );
  }

  getAttendanceWidget() {
    return Container(
      width: Numeral.WIDTH_SCREEN * 0.8,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            const BoxShadow(
                blurRadius: 4, spreadRadius: 4, color: Colors.black12)
          ]),
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            getAttendanceTimeWidget(
                "assets/icons/ic_attendance_in.svg",
                "Check in",
                controller.lastCheckIn.value,
                AppColor.primaryGreen),
            getAttendanceTimeWidget("assets/icons/ic_attendance_out.svg",
                "Check out", controller.lastCheckOut.value, AppColor.lightRed),
            getAttendanceTimeWidget(
                "assets/icons/ic_attendance_time.svg",
                "workingH".tr,
                controller.lastDuration.value,
                AppColor.primaryBlue)
          ],
        ),
      ),
    );
  }

  getAttendanceTimeWidget(
      String imagePath, String label, String time, Color color) {
    return Column(
      children: [
        SvgPicture.asset(imagePath,
            height: 22, width: 22, fit: BoxFit.scaleDown),
        const SizedBox(height: 7),
        BaseText(
          text: time,
          colorText: color,
          size: 21,
          isTile: true,
        ),
        const SizedBox(height: 2),
        BaseText(
          text: label,
          colorText: AppColor.primaryGrey,
          size: 13,
          isTile: true,
        ),
      ],
    );
  }

  getStatisticWidget() {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: Numeral.WIDTH_SCREEN * 0.04,
            ),
            BaseText(
              text: "statistics_for_the_month".tr,
              size: 20,
              isTile: true,
              colorText: AppColor.primaryGrey,
            ),
          ],
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Obx(
          () => Wrap(
            runSpacing: 14,
            spacing: 18,
            children: List.generate(controller.statisticCards.length, (index) {
              CardStatisticModel currentCard = controller.statisticCards[index];
              return BaseCardStatistics(
                text: currentCard.label,
                value: currentCard.value,
                sizeValue: 35,
                icon: Icon(
                  currentCard.icon,
                  color: Colors.white,
                  size: 28,
                ),
                beginColor: currentCard.color,
                endColor: currentCard.color.withOpacity(0.75),
              );
            }),
          ),
        ),
        SizedBox(
          height: Get.height * 0.04,
        ),
      ],
    );
  }
}
