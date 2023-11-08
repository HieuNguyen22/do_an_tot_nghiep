import 'package:flutter/material.dart';
import 'package:get/get.dart';

// File base_widget
// @project RunApp
// @author hoangminhk4b on 25-05-2022
class BaseWidget extends StatelessWidget {
  final Widget? leading;
  final String? title;
  final bool centerTitle;
  final List<Widget> actions;
  final Widget child;
  final Widget? bottomNavigationBar;
  final bool? isMargin;
  final double? sizeText;

  const BaseWidget(
      {Key? key,
      this.leading,
      this.title,
      this.centerTitle = true,
      this.actions = const [],
      required this.child,
      this.bottomNavigationBar,
      this.isMargin,
      this.sizeText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: leading ??
            (ModalRoute.of(context)?.canPop == true
                ? IconButton(
                    padding: const EdgeInsets.all(10),
                    onPressed: () {
                      Get.back(result: true);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                      color: Colors.  black,
                    ),
                  )
                : null),
        title: title != null
            ? Text(
                title!,
                style:  TextStyle(
                  color: Colors.black,
                  fontSize: sizeText??18,
                  fontFamily: 'MyFont',
                  fontWeight: FontWeight.bold
                ),
              )
            : null,
        centerTitle: centerTitle,
        actions: actions,
      ),
      body: Container(
        margin: isMargin ?? true
            ? const EdgeInsets.fromLTRB(16, 16, 16, 0)
            : const EdgeInsets.all(0),
        constraints: const BoxConstraints.expand(),
        child: child,
      ),
    );
  }
}
