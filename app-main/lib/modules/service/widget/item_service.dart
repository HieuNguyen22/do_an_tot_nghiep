import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/manage/controllers/manage_controller.dart';
import 'package:app_work_log/modules/service/controllers/service_controller.dart';
import 'package:app_work_log/routes/app_pages.dart';

// ignore: must_be_immutable
class ItemService extends StatelessWidget {
  ItemService({Key? key, required this.index, required this.isbook})
      : super(key: key);
  int index;
  var controller = Get.find<ServiceController>();
  bool isbook;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return InkWell(
        onTap: () {
          if (isbook) {
            controller.checkChooseSecive.value = index;
          }
        },
        child: Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(bottom: 20),
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/images/service/spa2.jpg"),
                fit: BoxFit.cover),
            border: controller.checkChooseSecive.value == index
                ? Border.all(color: Colors.yellow, width: 2)
                : const Border.fromBorderSide(BorderSide.none),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  text: controller.listService[index].shortDescription,
                  colorText: Colors.white,
                  centerText: TextAlign.start,
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText(
                        text: "${controller.listService[index].price}k",
                        colorText: Colors.yellow,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.SERVICE_DETAIL, arguments: {
                            "SERVICE": controller.listService[index]
                          });
                        },
                        child: BaseText(
                          text: "view-detail".tr,
                          styleText: FontStyle.italic,
                          colorText: Colors.yellow,
                          textDecoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
