import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseButtonLogin extends StatelessWidget {
  final double? height;
  final double? width;
  final bool? hasArrow;
  final String? title;
  final Color? textColor;
  final double? fontSize;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? borderRadius;
  final Color? colorBegin;
  final Color? colorEnd;
  final FontWeight? fontWeight;
  final double? widthBorder;
  final Widget? icon;

  const BaseButtonLogin(
      {super.key,
      this.height,
      this.width,
      this.hasArrow,
      required this.title,
      this.textColor,
      this.fontSize,
      this.verticalPadding,
      this.horizontalPadding,
      this.borderRadius,
      this.colorBegin,
      this.colorEnd,
      this.fontWeight,
      this.widthBorder,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colorBegin ?? AppColor.primaryBlue.withOpacity(0.9),
            colorEnd ?? AppColor.primaryPurple.withOpacity(0.9)
          ],
          stops: const [0.1, 0.9],
        ),
        borderRadius: BorderRadius.circular(
          borderRadius ?? 8,
        ),
        border: Border.all(
            color: widthBorder != null
                ? AppColor.primaryBlue.withOpacity(0.9)
                : Colors.white,
            width: widthBorder ?? 0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 0, vertical: verticalPadding ?? 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox(),
            const SizedBox(width: 6),
            Text(
              title!,
              style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: fontSize ?? 13,
                  fontWeight: fontWeight ?? FontWeight.normal),
            ),
            hasArrow ?? false
                ? Icon(Icons.arrow_forward_ios_rounded,
                    color: textColor, size: fontSize)
                : Container(),
          ],
        ),
      ),
    );
  }
}
