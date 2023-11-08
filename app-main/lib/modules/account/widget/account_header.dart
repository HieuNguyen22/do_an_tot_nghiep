import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/languages/language_service.dart';
import 'package:app_work_log/modules/account/controllers/account_controller.dart';
import 'package:app_work_log/modules/notification/controllers/notification_controller.dart';
import 'package:app_work_log/modules/home/controllers/home_controller.dart';
import 'package:app_work_log/oauth2/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountHeader extends GetView<AccountController> {
  const AccountHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.025),
              height: Numeral.WIDTH_SCREEN * 0.2,
              width: Numeral.WIDTH_SCREEN * 0.2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    width: 1,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  shape: BoxShape.circle),
              child: Center(
                child: BaseText(
                  text: controller.userFullName.value[0],
                  isTile: true,
                  size: 24,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.0125),
              child: BaseText(
                text: controller.userFullName.value,
                isTile: true,
                size: 18,
              ),
            ),
            // BaseText(
            //   text: "Product Manager",
            //   size: 16,
            // ),
          ],
        ),
      ),
    );
  }
}
