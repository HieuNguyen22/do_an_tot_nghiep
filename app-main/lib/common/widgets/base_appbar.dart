import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseAppBar extends StatelessWidget {
  final String title;
  final Widget action;
  final TextStyle? titleStyle;
  final bool hasBack;
  final Widget? actionLeft;

  const BaseAppBar({super.key, required this.title, required this.action, this.titleStyle, required this.hasBack, this.actionLeft});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // actionLeft ?? Container(),
        hasBack
            ? GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
              )
            : const SizedBox(),
        Text(
          title,
          style: titleStyle ?? TextStyle(fontWeight: FontWeight.w600, fontSize: 22, color: AppColor.primaryText),
        ),
        action
      ],
    );
  }
}
