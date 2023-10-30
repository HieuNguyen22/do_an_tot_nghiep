import 'dart:async';

import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/languages/language_service.dart';
import 'package:attendance_fast/oauth2/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../themes/app_color.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    switch (Get.find<AuthService>().languageApp) {
      case 1:
        LanguageService.changeLocale("en");
        break;
      case 2:
        LanguageService.changeLocale("vi");
        break;
      case 3:
        LanguageService.changeLocale("jp");
        break;
      default:
        LanguageService.changeLocale("en");
        break;
    }
    Timer(const Duration(seconds: 3), () async {
      final authService = Get.find<AuthService>();
      if (authService.authed.value) {
        return Get.offAllNamed(Routes.HOME);
      }
      Get.offNamed(Routes.INTRO);
    });

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2500),
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.primaryWhite,
      ),
      child: Center(
          child: FadeTransition(
        opacity: _animation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/ic_logo_trans_bg.png",
              width: Numeral.WIDTH_SCREEN * 0.12,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 10,
            ),
            DefaultTextStyle(
                style: TextStyle(color: AppColor.primaryGrey),
                child: const Text(
                  "Attendance Fast",
                ))
          ],
        ),
      )),
    );
  }
}
