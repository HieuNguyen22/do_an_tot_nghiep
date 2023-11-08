import 'package:app_work_log/common/global.dart';
import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/manage/controllers/manage_controller.dart';
import 'package:app_work_log/modules/manage/widgets/item_manage.dart';
import 'package:app_work_log/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageView extends GetView<ManageController> {
  const ManageView({Key? key}) : super(key: key);

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
              "assets/images/common/img_bg_2.png",
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BaseText(
                  text: "manage".tr,
                  isTile: true,
                  size: 24,
                ),
              ),
              Obx(
                () => Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Container(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        child: Wrap(
                          children: List.generate(controller.listManage.length,
                              (index) {
                            return ItemManage(
                              index: index,
                              icon: controller.listManage[index].icon!,
                              color: controller.listManage[index].color!,
                              text: controller.listManage[index].text!,
                              voidCallback: () {
                                if (index == Numeral.SELECT_ATTENDANCE_CHECKIN) {
                                  Get.toNamed(Routes.ATTENDANCE_MANAGE, arguments: Numeral.SELECT_LIST_CHECKIN);
                                } else if (index == Numeral.SELECT_ATTENDANCE_LATE) {
                                  Get.toNamed(Routes.ATTENDANCE_MANAGE, arguments: Numeral.SELECT_LIST_LATE);
                                } else if (index == Numeral.SELECT_ATTENDANCE_CASUAL_LEAVE) {
                                  Get.toNamed(Routes.ATTENDANCE_MANAGE, arguments: Numeral.SELECT_LIST_CASUAL_LEAVE);
                                } else if (index == Numeral.SELECT_DASHBOARD_STATISTICS) {
                                  Get.toNamed(Routes.DASHBOARD_STATISTICS);
                                } else if (index == Numeral.SELECT_LEAVE_REQUESTS) {
                                  Get.toNamed(Routes.LEAVE_REQUESTS_MANAGE);
                                } else if (index == Numeral.SELECT_OVERTIME_REQUESTS) {
                                  Get.toNamed(Routes.OVERTIME_REQUESTS_MANAGE);
                                } else if (index == Numeral.SELECT_STAFF) {
                                  Get.toNamed(Routes.STAFF_MANAGE);
                                } else if (index == Numeral.SELECT_DEPARTMENT) {
                                  Get.toNamed(Routes.DEPARTMENT_MANAGE);
                                } else if (index == Numeral.SELECT_SHIFT) {
                                  Get.toNamed(Routes.SHIFT_MANAGE);
                                } else if (index == Numeral.SELECT_PROFILE_COMPANY) {
                                  Get.toNamed(Routes.COMPANY_PROFILE);
                                } else if (index == Numeral.SELECT_COMPANY_SETTING) {
                                  Get.toNamed(Routes.COMPANY_SETTING);
                                }
                              },
                            );
                          }),
                        ),
                      ),
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
}
