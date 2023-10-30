import 'package:attendance_fast/common/utils/numeral.dart';
import 'package:attendance_fast/common/widgets/base_text.dart';
import 'package:attendance_fast/modules/department_manage/model/department_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDepartment extends StatelessWidget {
  final DepartmentManage item;
  const ItemDepartment({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(Numeral.WIDTH_SCREEN * 0.025),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: Numeral.WIDTH_SCREEN * 0.025,),
                  child: Row(
                    children: [
                      BaseText(
                        text: item.name,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: Numeral.WIDTH_SCREEN * 0.05,),
                  child: Row(
                    children: [
                      BaseText(
                        text: item.managerInfo == null ? "" : item.managerInfo!.firstName == null || item.managerInfo!.firstName == null ? "No Name" : "${item.managerInfo!.firstName} ${item.managerInfo!.lastName!}",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
