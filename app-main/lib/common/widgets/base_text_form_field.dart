import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseTextFormField extends StatelessWidget {
  final String label;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? readOnly;
  final int? maxLines;
  final Color? textColor;
  final TextEditingController? controller;
  final String? Function(String?)? validateFunction;
  final TextInputType? textInputType;
  final bool? obscureText;
  final bool? enabled;

  const BaseTextFormField(
      {super.key,
      required this.label,
      this.prefixIcon,
      this.suffixIcon,
      this.readOnly,
      this.maxLines,
      this.controller,
      this.hint, this.validateFunction, this.textInputType, this.obscureText, this.enabled, this.textColor,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        cursorColor: Colors.black,
        keyboardType: textInputType ?? TextInputType.text,
        readOnly: readOnly ?? false,
        maxLines: maxLines ?? 1,
        obscureText: obscureText ?? false,
        enabled: enabled ?? true,
        style: TextStyle(color: textColor ?? AppColor.primaryGrey),
        decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding:
                const EdgeInsets.only(left: 15, bottom: 13, top: 13, right: 15),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintStyle: TextStyle(color: AppColor.primaryGrey, fontSize: 14),
            hintText: hint),
        validator: validateFunction);
  }
}
