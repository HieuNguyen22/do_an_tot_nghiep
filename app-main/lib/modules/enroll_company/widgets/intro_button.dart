import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_button.dart';
import 'package:app_work_log/common/widgets/base_button_login.dart';
import 'package:app_work_log/common/widgets/base_gradient_text.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroButton extends StatelessWidget {
  final String label;
  final String description;
  final String imagePath;
  final String buttonLabel;

  const IntroButton(
      {super.key,
      required this.label,
      required this.description,
      required this.imagePath,
      required this.buttonLabel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Numeral.WIDTH_SCREEN * 0.9,
      height: Get.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
            image: AssetImage("assets/images/login/img_bg_button_intro.png"), fit: BoxFit.cover),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, spreadRadius: 4, blurRadius: 7)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GradientText(
              label.tr,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              gradient: LinearGradient(colors: [
                AppColor.primaryBlue,
                AppColor.primaryPurple,
              ]),
            ),
            Text(
              description.tr,
              style: TextStyle(color: AppColor.primaryGrey, fontSize: 13),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  imagePath,
                  height: Get.height * 0.1,
                  width: Numeral.WIDTH_SCREEN * 0.5,
                  fit: BoxFit.fill,
                ),
                BaseButtonLogin(
                    height: Get.height * 0.05,
                    width: Numeral.WIDTH_SCREEN * 0.295,
                    hasArrow: true,
                    title: buttonLabel.tr,
                    fontSize: 13,
                    verticalPadding: 8,
                    horizontalPadding: 12,
                    textColor: Colors.white,
                    colorBegin: AppColor.primaryBlue,
                    colorEnd: AppColor.primaryPurple,
                    fontWeight: FontWeight.normal,
                    borderRadius: 7)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
