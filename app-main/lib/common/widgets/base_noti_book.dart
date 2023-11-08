import 'package:app_work_log/common/widgets/base_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BaseNotiBook extends StatelessWidget {
  BaseNotiBook({Key? key, required this.text}) : super(key: key);
  String? text = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: const Color(0xFFecf7ef),
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage(
                    "assets/images/service/spa1.jpg",
                  ),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: BaseText(
              text: text,
              centerText: TextAlign.start,
            ),
          )
        ],
      ),
    );
  }
}
