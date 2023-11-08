import 'package:app_work_log/common/utils/numeral.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

/// Dialog loading
Future showLoading() async {
  return showDialog(
    routeSettings: const RouteSettings(name: "showDialog"),
    barrierDismissible: false,
    context: Get.context!,
    useRootNavigator: true,
    builder: (context) => Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Center(
        child: SizedBox(
          width: Numeral.WIDTH_SCREEN * 0.3,
          height: Numeral.WIDTH_SCREEN * 0.3,
          child: Lottie.asset("assets/jsons/loading.json", fit: BoxFit.fill),
        ),
      ),
    ),
  );
}

closeLoading() {
  final context = Get.overlayContext;
  if (context != null) {
    Navigator.of(context, rootNavigator: true)
        .popUntil((route) => route.settings.name != "showDialog");
  }
}

/// Toast
showToast(String message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 14.0,
      backgroundColor: Colors.black45);
}

showToastComingSoon({
  required BuildContext context,
  ToastGravity? gravity,
}) async {
  FToast fToast = FToast();
  fToast.init(context);

  fToast.showToast(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              alignment: Alignment.center,
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color.fromRGBO(79, 112, 255, 1),
              ),
              child: const Text("i", style: TextStyle(color: Colors.white))),
          const SizedBox(
            width: 12.0,
          ),
          const Text("Upcoming feature. Coming soon!"),
        ],
      ),
    ),
    gravity: gravity ?? ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
  );
}

extension ErrorHandler on dynamic {
  get show {
    if (this is DioException) {
      final dioError = this as DioException;
      showToast(dioError.error.toString());
    } else {
      showToast(toString());
    }
  }
}
