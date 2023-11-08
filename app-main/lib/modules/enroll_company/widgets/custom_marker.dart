import 'package:app_work_log/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomMarker extends StatelessWidget {
  const CustomMarker({Key? key, required this.color}) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.neutral[50],
        ),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: FaIcon(
            FontAwesomeIcons.solidCircleDot,
            size: 30,
            color: color,
          ),
        ),
      ),
      // Container(
      //   padding: EdgeInsets.symmetric(horizontal: 1),
      //   color: CustomColors.neutral[50],
      //   child: Container(
      //     height: 6,
      //     width: 4,
      //     color: Colors.white,
      //   ),
      // ),
      // Container(
      //   width: 6,
      //   height: 1,
      //   color: CustomColors.neutral[50],
      // )
    ]);
  }
}
