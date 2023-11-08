import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BaseWorkingTimetable extends StatefulWidget {
  const BaseWorkingTimetable({super.key});

  @override
  State<BaseWorkingTimetable> createState() => _BaseWorkingTimetableState();
}

class _BaseWorkingTimetableState extends State<BaseWorkingTimetable> {
  final DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemCount: daysInMonth,
      itemBuilder: (context, index) {
        final day = index + 1;
        final date = DateTime(now.year, now.month, day);
        final dayName = DateFormat('E').format(date); // Ngày trong tuần

        return Column(
          children: [
            Text(
              day.toString(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              dayName,
              style: TextStyle(fontSize: 16),
            ),
            // Các phần tử Text khác mà bạn muốn thêm dưới ngày
          ],
        );
      },
    );
  }
}
