import 'package:app_work_log/common/utils/numeral.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/common/widgets/base_widget.dart';
import 'package:app_work_log/modules/manage/controllers/manage_controller.dart';
import 'package:app_work_log/modules/service/controllers/service_controller.dart';
import 'package:app_work_log/modules/service/widget/item_service.dart';
import 'package:app_work_log/themes/app_color.dart';

class ServiceView extends GetView<ServiceController> {
  const ServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isbook = Get.arguments["BOOK"] ?? "";

    return BaseWidget(
      title: "Price List",
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(color: Colors.orange, width: 5))),
                  child: BaseText(
                    text: "combo-service".tr,
                    isTile: true,
                    centerText: TextAlign.start,
                  ),
                ),
                SizedBox(
                  width: Numeral.WIDTH_SCREEN,
                  child: Image.asset(
                    "assets/images/service/imageHeader.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  child: BaseText(
                    text:
                        "content-combo-service".tr,
                  ),
                ),
                Obx(() {
                  return Container(
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: 20,
                      children: List.generate(
                        controller.listService.length,
                        (index) => ItemService(
                          index: index,
                          isbook: isbook == "BOOKSERVICE",
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          if (isbook == "BOOKSERVICE")
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: Numeral.WIDTH_SCREEN,
                padding: const EdgeInsets.symmetric(vertical: 12),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColor.primaryBlue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: BaseText(
                  text: "choose-services".tr,
                  colorText: Colors.white,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
