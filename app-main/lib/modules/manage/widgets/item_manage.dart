import 'package:app_work_log/common/utils/numeral.dart';
import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ItemManage extends StatelessWidget {
  final int index;
  final String icon;
  final Color color;
  final String text;
  final VoidCallback voidCallback;
  const ItemManage(
      {super.key,
      required this.index,
      required this.icon,
      required this.color,
      required this.text,
      required this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: voidCallback,
      child: Container(
        margin: index % 2 == 0
            ? EdgeInsets.only(top: Get.height * 0.015, right: Numeral.WIDTH_SCREEN * 0.0125)
            : EdgeInsets.only(top: Get.height * 0.015, left: Numeral.WIDTH_SCREEN * 0.0125),
        height: Numeral.WIDTH_SCREEN * 0.15,
        width: Numeral.WIDTH_SCREEN * 0.45,
        child: Row(children: [
          Container(
            height: Numeral.WIDTH_SCREEN * 0.15,
            width: Numeral.WIDTH_SCREEN * 0.15,
            decoration: BoxDecoration(
                color: color,
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(20))),
            child: Center(
              child: SvgPicture.asset("assets/images/manage/$icon"),
            ),
          ),
          Container(
            height: Numeral.WIDTH_SCREEN * 0.15,
            width: Numeral.WIDTH_SCREEN * 0.3,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
                bottom: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
                right: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                  width: 1,
                ),
              ),
            ),
            child: Center(
              child: BaseText(
                text: text,
                size: 12,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
