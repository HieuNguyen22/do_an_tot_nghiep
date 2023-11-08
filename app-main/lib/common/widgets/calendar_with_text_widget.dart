import 'package:app_work_log/themes/app_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWithTextWidget extends StatefulWidget {
  const CalendarWithTextWidget({super.key});

  @override
  State<CalendarWithTextWidget> createState() => _CalendarWithTextWidgetState();
}

class _CalendarWithTextWidgetState extends State<CalendarWithTextWidget> {
  // CalendarController _calendarController;
  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  Map<String, String> events = {};

  @override
  void initState() {
    super.initState();
    // _calendarController = CalendarController();
    events["20-08-2023"] = "8h";
    events["21-08-2023"] = "7h30";
    events[currentDate] = "6h50";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2023, 01, 01),
          lastDay: DateTime.utc(2023, 12, 31),
          focusedDay: DateTime.now(),
          headerVisible: true,
          calendarBuilders:
              CalendarBuilders(defaultBuilder: (context, date, _) {
            String checkDate = DateFormat('dd-MM-yyyy').format(date);
            final event = events[checkDate];
            return Container(
              margin: EdgeInsets.all(4),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    DateFormat('d').format(date),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primaryText
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      event ?? '',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColor.primaryBlue,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );
          }, todayBuilder: (context, date, _) {
            String checkDate = DateFormat('dd-MM-yyyy').format(date);
            final event = events[checkDate];
            return Container(
              margin: EdgeInsets.all(4),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.primaryBlue
                    ),
                    child: Text(
                      DateFormat('d').format(date),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(
                      event ?? '',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColor.primaryBlue,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            );
          }),
        )
      ],
    );
  }

  @override
  void dispose() {
    // _calendarController.dispose();
    super.dispose();
  }
}
