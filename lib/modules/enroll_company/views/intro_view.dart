import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/modules/enroll_company/widgets/intro_button.dart';
import 'package:attendance_fast/routes/app_pages.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: Numeral.WIDTH_SCREEN,
        height: Get.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/common/img_bg_1.png"),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/icons/ic_logo_white_bg.png",
              width: Numeral.WIDTH_SCREEN * 0.1,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 10,
            ),
            DefaultTextStyle(
                style: TextStyle(color: AppColor.primaryGrey),
                child: const Text(
                  "Attendance Fast",
                )),
            const SizedBox(
              height: 15,
            ),

            GestureDetector(
              onTap: () => Get.toNamed(Routes.ENROLL_COMPANY),
              child: const IntroButton(
                label: "intro_enroll_company",
                buttonLabel: 'intro_enroll_company_button_label',
                description: 'intro_enroll_company_desc',
                imagePath: 'assets/images/enroll_company/img_company_intro.png',
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            GestureDetector(
              onTap: () => Get.toNamed(Routes.SIGN_UP),
              child: const IntroButton(
                label: "intro_sign_up_staff",
                buttonLabel: 'intro_sign_up_staff_button_label',
                description: 'intro_sign_up_staff_desc',
                imagePath: 'assets/images/enroll_company/img_staff_intro.png',
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            GestureDetector(
              onTap: () => Get.toNamed(Routes.LOGIN),
              child: const IntroButton(
                label: "intro_sign_in",
                buttonLabel: 'intro_sign_in_button_label',
                description: 'intro_sign_in_desc',
                imagePath: 'assets/images/enroll_company/img_signin_intro.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
