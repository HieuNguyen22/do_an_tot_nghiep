import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:attendance_fast/common/utils/dialog.dart';
import 'package:attendance_fast/common/widgets/base_text.dart';
import 'package:attendance_fast/languages/language_service.dart';
import 'package:attendance_fast/modules/login/controllers/login_controller.dart';
import 'package:attendance_fast/oauth2/service/auth_service.dart';
import 'package:attendance_fast/routes/app_pages.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  int pageIndex = 0;

  List<Widget> listWidget = [
    const IntroOne(),
    const IntroTwo(),
    const IntroThree(),
  ];

    @override
  void initState() {
    // TODO: implement initState
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.green.withOpacity(0.5), Colors.white]),
              ),
              width: double.infinity,
              height: Get.height,
              child: PageView(
                children: listWidget,
                onPageChanged: (index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CarouselIndicator(
            color: Colors.grey,
            activeColor: const Color(0xFF2EDA93),
            width: 10,
            height: 10,
            count: listWidget.length,
            index: pageIndex,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  showLoading();
                  //await Get.find<LoginController>().checkLogin();
                  Get.toNamed(Routes.HOME);
                  closeLoading();
                },
                child: const BaseText(
                  text: "Skip",
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 10,
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class IntroOne extends StatelessWidget {
  const IntroOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                BaseText(
                  text: "title-overview-slide1".tr,
                  isTile: true,
                  size: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                BaseText(
                  text: "content-overview-slide1-1".tr,
                ),
                SizedBox(
                  height: 5,
                ),
                BaseText(
                  text: "content-overview-slide1-2".tr,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IntroTwo extends StatelessWidget {
  const IntroTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                BaseText(
                  text: "title-overview-slide2".tr,
                  isTile: true,
                  size: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                BaseText(
                  text: "content-overview-slide2".tr,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IntroThree extends StatelessWidget {
  const IntroThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                BaseText(
                  text: "title-overview-slide3".tr,
                  isTile: true,
                  size: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                BaseText(
                  text: "content-overview-slide3-1".tr,
                ),
                SizedBox(
                  height: 5,
                ),
                BaseText(
                  text: "content-overview-slide3-2".tr,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
