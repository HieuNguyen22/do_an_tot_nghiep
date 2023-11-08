import 'dart:convert';

List<TimeWorkingDate> timeWorkingDateFromJson(List<dynamic> str) => List<TimeWorkingDate>.from(str.map((x) => TimeWorkingDate.fromJson(x)));

String timeWorkingDateToJson(List<TimeWorkingDate> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimeWorkingDate {
    DateTime? date;
    double? time;

    TimeWorkingDate({
        this.date,
        this.time,
    });

    factory TimeWorkingDate.fromJson(Map<String, dynamic> json) => TimeWorkingDate(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
    };
}
