import 'package:app_work_log/themes/app_colors.dart';
import 'package:app_work_log/themes/app_text_theme.dart';
import 'package:clippy_flutter/triangle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



const COLOR_OF_INFO_WINDOW = 1;
const TEXT_OF_INFO_WINDOW = 2;
class CustomInfoWindowWidget extends StatelessWidget {
  const CustomInfoWindowWidget({this.numOfDriver, this.child}) : assert((numOfDriver != null) || (child != null));

  final int? numOfDriver;
  final Widget? child;

  /// type == 1 return Colors
  /// type == 2 return Text
  checkDriver({required type}){
    if(numOfDriver == 0){
      return type == COLOR_OF_INFO_WINDOW ? Colors.red :
      RichText(text: TextSpan(
          children: [
            TextSpan(text: '${'nearby_driver'.tr}\n', style: CustomTextStyle.body3(color:Colors.white, height: 1.5,fontWeight: FontWeight.normal)),
            TextSpan(text: 'driver_not_found'.tr, style: CustomTextStyle.body4(color:Colors.white, height: 1.5))
          ]
      ), textAlign: TextAlign.center,);
    } else if(numOfDriver! >= 1 && numOfDriver! <= 29){
      return type == COLOR_OF_INFO_WINDOW ? Colors.white : RichText(text: TextSpan(
        children: [
          TextSpan(text: '${'nearby_driver'.tr}\n', style: CustomTextStyle.body3(height: 1.5,fontWeight: FontWeight.normal)),
          TextSpan(text: '△ ', style: CustomTextStyle.body4(color: CustomColors.blue, height: 1.5)),
          TextSpan(text: 'driver_less'.tr, style: CustomTextStyle.body4(height: 1.5))
        ]
      ), textAlign: TextAlign.center,);
    } else if (numOfDriver! >= 30 && numOfDriver! <= 99) {
      return type == COLOR_OF_INFO_WINDOW ? Colors.white :RichText(text: TextSpan(
          children: [
            TextSpan(text: '${'nearby_driver'.tr}\n', style: CustomTextStyle.body3(height: 1.5,fontWeight: FontWeight.normal)),
            TextSpan(text: '○ ', style: CustomTextStyle.body4(color: CustomColors.yellow, height: 1.5)),
            TextSpan(text: 'driver_more'.tr, style: CustomTextStyle.body4(height: 1.5))
          ]
      ), textAlign: TextAlign.center,);
    } else {
      return type == COLOR_OF_INFO_WINDOW ? Colors.white :RichText(text: TextSpan(
          children: [
            TextSpan(text: '${'nearby_driver'.tr}\n', style: CustomTextStyle.body3(height: 1.5,fontWeight: FontWeight.normal)),
            TextSpan(text: '◎ ', style: CustomTextStyle.body4(color: CustomColors.red, height: 1.5)),
            TextSpan(text: 'driver_many'.tr, style: CustomTextStyle.body4(height: 1.5))
          ]
      ), textAlign: TextAlign.center,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          decoration: BoxDecoration(
            color: child != null ? Colors.white : checkDriver(type: COLOR_OF_INFO_WINDOW),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: child ?? checkDriver(type: TEXT_OF_INFO_WINDOW),
        ),
        Triangle.isosceles(
          edge: Edge.BOTTOM,
          child: Container(
            color: child != null ? Colors.white : checkDriver(type: COLOR_OF_INFO_WINDOW),
            width: 20.0,
            height: 10.0,
          ),
        ),
      ],
    );
  }
}
