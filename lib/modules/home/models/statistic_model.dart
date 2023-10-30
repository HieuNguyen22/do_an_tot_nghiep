import 'dart:convert';

StatisticModel statisticFromJson(Map<String, dynamic> str) => StatisticModel.fromJson(str);

String statisticToJson(StatisticModel data) => json.encode(data.toJson());

class StatisticModel {
    int? workingDays;
    double? workingHours;
    int? leaveRequest;
    double? hoursOff;
    int? overtimeRequest;
    double? overtimeHours;
    int? lateArrivals;
    int? earlyLeaving;

    StatisticModel({
        this.workingDays,
        this.workingHours,
        this.leaveRequest,
        this.hoursOff,
        this.overtimeRequest,
        this.overtimeHours,
        this.lateArrivals,
        this.earlyLeaving,
    });

    factory StatisticModel.fromJson(Map<String, dynamic> json) => StatisticModel(
        workingDays: json["working_days"],
        workingHours: json["working_hours"]?.toDouble(),
        leaveRequest: json["leave_request"],
        hoursOff: json["leave_off"]?.toDouble(),
        overtimeRequest: json["overtime_request"],
        overtimeHours: json["overtime_off"].toDouble(),
        lateArrivals: json["late_arrivals"],
        earlyLeaving: json["early_leaving"],
    );

    Map<String, dynamic> toJson() => {
        "working_days": workingDays,
        "working_hours": workingHours,
        "leave_request": leaveRequest,
        "leave_off": hoursOff,
        "overtime_request": overtimeRequest,
        "overtime_off": overtimeHours,
        "late_arrivals": lateArrivals,
        "early_leaving": earlyLeaving,
    };
}
