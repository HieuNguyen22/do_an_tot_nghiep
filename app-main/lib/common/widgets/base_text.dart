import 'package:app_work_log/themes/app_color.dart';
import 'package:app_work_log/themes/style_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseText extends StatelessWidget {
  final String? text;
  final TextAlign? centerText;
  final double? size;
  final bool? isTile;
  final bool? isUpper;
  final Color? colorText;
  final FontStyle? styleText;
  final TextDecoration? textDecoration;
  const BaseText(
      {super.key,
      this.text,
      this.centerText,
      this.size,
      this.isTile,
      this.colorText,
      this.styleText,
      this.textDecoration,
      this.isUpper});
  @override
  Widget build(BuildContext context) {
    return Text(
      isUpper ?? false ? "$text".tr.toUpperCase() : "$text".tr,
      style: styleTitle.copyWith(
        fontWeight: isTile ?? false ? FontWeight.bold : FontWeight.normal,
        fontSize: size ?? 13,
        fontStyle: styleText ?? FontStyle.normal,
        decoration: textDecoration ?? TextDecoration.none,
        color: colorText ?? AppColor.colorTextGreyDark,
      ),
      textAlign: centerText ?? TextAlign.center,
    );
  }
}
