import 'package:attendance_fast/common/widgets/base_text.dart';
import 'package:flutter/material.dart';

class ItemOptionAccount extends StatelessWidget {
  final Widget img;
  final String name;
  final VoidCallback clickItem;
  const ItemOptionAccount({Key? key, required this.img, required this.name, required this.clickItem,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: clickItem,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.grey.withOpacity(0.3)))),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: img,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: BaseText(
                          text: name,
                          size: 13,
                            centerText: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 13,
                  color: Colors.grey,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
