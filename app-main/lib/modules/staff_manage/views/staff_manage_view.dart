import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:app_work_log/common/widgets/base_text_form_field.dart';
import 'package:app_work_log/modules/staff_manage/controllers/staff_manage_controller.dart';
import 'package:app_work_log/modules/staff_manage/widgets/bottom_input_name_csv.dart';
import 'package:app_work_log/modules/staff_manage/widgets/item_staff.dart';
import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class StaffManageView extends GetView<StaffManageController> {
  const StaffManageView({Key? key}) : super(key: key);

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
                        text: "staff_manage".tr,
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
                            "assets/images/common/ic_export_csv.svg")),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Numeral.WIDTH_SCREEN * 0.05,
                    right: Numeral.WIDTH_SCREEN * 0.05,
                    top: Get.height * 0.025,
                    bottom: Get.height * 0.0125),
                decoration: BoxDecoration(
                  color: AppColor.lightPurple,
                ),
                child: TextFormField(
                  controller: controller.textSearch,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  readOnly: false,
                  maxLines: 1,
                  onChanged: (value) {
                     controller.getListStaff();
                  },
                  decoration: InputDecoration(
                    labelText: 'search_name_staff'.tr,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                        left: 15, bottom: 13, top: 13, right: 15),
                    prefixIcon: Icon(Icons.search,
                        color: AppColor.primaryGrey.withOpacity(0.8)),
                    hintStyle:
                        TextStyle(color: AppColor.primaryGrey, fontSize: 14),
                  ),
                ),
              ),
              Obx(
                () => Expanded(
                  child: (controller.listStaff.length == 1 &&
                          controller.listStaff[0].id == -1)
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppColor.primaryPurple),
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.listStaff.length,
                          itemBuilder: (context, index) {
                            return ItemStaff(
                              item: controller.listStaff[index],
                            );
                          },
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
