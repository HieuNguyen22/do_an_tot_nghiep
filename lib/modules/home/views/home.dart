import 'package:attendance_fast/common/global.dart';
import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_gradient_widget.dart';
import 'package:attendance_fast/modules/attendance/controllers/attendance_controller.dart';
import 'package:attendance_fast/modules/home/provider/home_provider.dart';
import 'package:attendance_fast/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:attendance_fast/modules/home/utils/home_func.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  late List<BottomNavigationBarItem> bottomItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bottomItems = [
      BottomNavigationBarItem(
          icon: selectedIndex == Numeral.SCREEN_HOME
              ? BaseGradientWidget(
                  widget: Icon(Icons.home_rounded, size: 34),
                  gradient: AppColor.primaryGradient)
              : BaseGradientWidget(
                  widget: Icon(Icons.home_outlined, size: 34),
                  gradient: AppColor.primaryGradient),
          label: 'Home'.tr),
      BottomNavigationBarItem(
          icon: selectedIndex == Numeral.SCREEN_ATTENDANCE
              ? BaseGradientWidget(
                  widget: Icon(Icons.how_to_reg_rounded, size: 34),
                  gradient: AppColor.primaryGradient)
              : BaseGradientWidget(
                  widget: Icon(Icons.how_to_reg_outlined, size: 34),
                  gradient: AppColor.primaryGradient),
          label: 'Attendance'.tr),
      BottomNavigationBarItem(
          icon: selectedIndex == Numeral.SCREEN_MANAGE
              ? BaseGradientWidget(
                  widget: Icon(Icons.groups_2_rounded, size: 34),
                  gradient: AppColor.primaryGradient)
              : BaseGradientWidget(
                  widget: Icon(Icons.groups_2_outlined, size: 34),
                  gradient: AppColor.primaryGradient),
          label: 'Manage'.tr),
      BottomNavigationBarItem(
          icon: selectedIndex == Numeral.SCREEN_NOTIFICATION
              ? BaseGradientWidget(
                  widget: Icon(Icons.notifications_rounded, size: 34),
                  gradient: AppColor.primaryGradient)
              : BaseGradientWidget(
                  widget: Icon(Icons.notifications_outlined, size: 34),
                  gradient: AppColor.primaryGradient),
          label: 'Notification'.tr),
      BottomNavigationBarItem(
          icon: selectedIndex == Numeral.SCREEN_PROFILE
              ? BaseGradientWidget(
                  widget: Icon(Icons.account_circle_rounded, size: 34),
                  gradient: AppColor.primaryGradient)
              : BaseGradientWidget(
                  widget: Icon(Icons.account_circle_outlined, size: 34),
                  gradient: AppColor.primaryGradient),
          label: 'Profile'.tr),
    ];
    getUserRoleCode();
  }

  @override
  Widget build(BuildContext context) {
    print(selectedIndex);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: HomeFunc.getBody(selectedIndex, Global.roleCodeUser),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF2EDA93),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: bottomItems,
          onTap: (routeIndex) async {
            selectedIndex = routeIndex;

            resetBottomItems();
            
            if (selectedIndex == Numeral.SCREEN_ATTENDANCE) {
              await Get.find<AttendanceController>().callApiGetListCheckIn();
            }
          },
        ));
  }

  /// Get user infor
  void getUserRoleCode() async {
    var result = await HomeProvider().getUserInfo();

    if (result.roleCode != null) {
      Global.roleCodeUser = result.roleCode!;
    }

    resetBottomItems();
  }

  resetBottomItems() {
    setState(() {
      bottomItems = [
        BottomNavigationBarItem(
            icon: selectedIndex == Numeral.SCREEN_HOME
                ? BaseGradientWidget(
                    widget: Icon(Icons.home_rounded, size: 34),
                    gradient: AppColor.primaryGradient)
                : BaseGradientWidget(
                    widget: Icon(Icons.home_outlined, size: 34),
                    gradient: AppColor.primaryGradient),
            label: 'Home'.tr),
        BottomNavigationBarItem(
            icon: selectedIndex == Numeral.SCREEN_ATTENDANCE
                ? BaseGradientWidget(
                    widget: Icon(Icons.how_to_reg_rounded, size: 34),
                    gradient: AppColor.primaryGradient)
                : BaseGradientWidget(
                    widget: Icon(Icons.how_to_reg_outlined, size: 34),
                    gradient: AppColor.primaryGradient),
            label: 'Attendance'.tr),
        BottomNavigationBarItem(
            icon: selectedIndex == Numeral.SCREEN_MANAGE
                ? BaseGradientWidget(
                    widget: Icon(Icons.groups_2_rounded, size: 34),
                    gradient: AppColor.primaryGradient)
                : BaseGradientWidget(
                    widget: Icon(Icons.groups_2_outlined, size: 34),
                    gradient: AppColor.primaryGradient),
            label: 'Manage'.tr),
        BottomNavigationBarItem(
            icon: selectedIndex == Numeral.SCREEN_NOTIFICATION
                ? BaseGradientWidget(
                    widget: Icon(Icons.notifications_rounded, size: 34),
                    gradient: AppColor.primaryGradient)
                : BaseGradientWidget(
                    widget: Icon(Icons.notifications_outlined, size: 34),
                    gradient: AppColor.primaryGradient),
            label: 'Notification'.tr),
        BottomNavigationBarItem(
            icon: selectedIndex == Numeral.SCREEN_PROFILE
                ? BaseGradientWidget(
                    widget: Icon(Icons.account_circle_rounded, size: 34),
                    gradient: AppColor.primaryGradient)
                : BaseGradientWidget(
                    widget: Icon(Icons.account_circle_outlined, size: 34),
                    gradient: AppColor.primaryGradient),
            label: 'Profile'.tr),
      ];
      if (Global.roleCodeUser != 2 && Global.roleCodeUser != 3) {
        bottomItems.removeAt(2);
      }
    });
  }
}
