import 'package:app_work_log/themes/app_color.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseDialog {
  static getBaseDialog(
      {required BuildContext context,
      DialogType? dialogType,
      Color? buttonColor,
      Color? textColor,
      String? title,
      String? desc}) {
    AwesomeDialog(
      context: context!,
      dialogType: dialogType ?? DialogType.success,
      animType: AnimType.scale,
      title: title ?? "",
      desc: desc ?? "",
      btnOkColor: buttonColor ?? AppColor.primaryGreen,
      btnOkOnPress: () {},
    ).show();
  }

  static getBaseInformDialog(
      {required BuildContext context,
      required String title,
      required String desc}) {
    showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(desc),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
