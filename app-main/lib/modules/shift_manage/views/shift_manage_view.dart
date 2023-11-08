import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/modules/shift_manage/controllers/shift_manage_controller.dart';
import 'package:app_work_log/modules/shift_manage/widgets/bottom_input_name_csv.dart';
import 'package:app_work_log/modules/shift_manage/widgets/item_shift.dart';
import 'package:app_work_log/modules/shift_manage/widgets/popup_add_shift.dart';
import 'package:app_work_log/modules/shift_manage/widgets/popup_detail_shift.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShiftManageView extends GetView<ShiftManageController> {
  const ShiftManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
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
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.chevron_left,
                              size: 24,
                            )),
                        Expanded(
                          child: BaseText(
                            text: "shift_manage".tr,
                            isTile: true,
                            size: 24,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.textNameFileCsv.value.text = "";
                            Get.bottomSheet(BottomInputNameCsv());
                          },
                          child: SvgPicture.asset(
                              "assets/images/common/ic_export_csv.svg"),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: Get.height * 0.06,
                    width: Numeral.WIDTH_SCREEN,
                    margin: EdgeInsets.only(
                      top: Get.height * 0.0125,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.colorBackgroundTitleTable,
                    ),
                    child: Row(children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: Numeral.WIDTH_SCREEN * 0.05,),
                              child: BaseText(
                                text: "name_shift".tr,
                                isTile: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: BaseText(
                                  text: "begin".tr,
                                  isTile: true,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: BaseText(
                                  text: "end".tr,
                                  isTile: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Obx(
                    () => Expanded(
                      child: (controller.listShift.length == 1 &&
                          controller.listShift[0].id == -1)
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColor.primaryPurple),
                          ),
                        )
                      : ListView.builder(
                        itemCount: controller.listShift.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              controller.chooseItemShift(controller.listShift[index]);
                              Get.bottomSheet(
                                isScrollControlled: true,
                                PopupDetailShift(),
                              );
                            },
                            child: ItemShift(item: controller.listShift[index],),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: Numeral.WIDTH_SCREEN * 0.05,
            right: Numeral.WIDTH_SCREEN * 0.05,
            child: InkWell(
                onTap: () {
                  controller.refreshInputShift();
                  Get.bottomSheet(
                    isScrollControlled: true,
                    PopupAddShift(),
                  );
                },
                child: SizedBox(
                  height: Numeral.WIDTH_SCREEN * 0.13,
                  width: Numeral.WIDTH_SCREEN * 0.13,
                  child: SvgPicture.asset("assets/images/manage/ic_add.svg"))),
          ),
        ],
      ),
    );
  }
}
