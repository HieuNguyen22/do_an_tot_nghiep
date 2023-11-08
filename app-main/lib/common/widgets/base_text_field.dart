import 'package:app_work_log/themes/app_color.dart';
import 'package:app_work_log/themes/style_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BaseTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final IconData? icon;
  final bool? obscureText;
  const BaseTextField({
    super.key,
    this.controller,
    this.hintText,
    this.errorText,
    this.icon,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText ?? false,
      controller: controller,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        hintText: hintText,
        hintStyle: styleTitle.copyWith(
          color: AppColor.colorIconGreyLight,
        ),
        errorText: errorText == "" ? null : errorText,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: AppColor.colorBackgorundTextFied,
        prefixIcon: Icon(
          icon,
          color: AppColor.colorIconGreyLight,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.colorBorderTextFied,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: AppColor.colorBackgorundTextFied, width: 0),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      autocorrect: false,
    );
  }
}
