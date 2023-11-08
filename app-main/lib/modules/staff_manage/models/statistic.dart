import 'dart:convert';

StatisticModel statisticFromJson(Map<String, dynamic> str) => StatisticModel.fromJson(str);

String statisticToJson(StatisticModel data) => json.encode(data.toJson());

class StatisticModel {
    num? workingDays;
    num? workingHours;
    num? lateArrivals;
    num? earlyLeaving;
    num? leaveRequest;
    num? hoursOff;
    num? overtimeRequest;
    num? overtimeHours;

    StatisticModel({
        this.workingDays,
        this.workingHours,
        this.lateArrivals,
        this.earlyLeaving,
        this.leaveRequest,
        this.hoursOff,
        this.overtimeRequest,
        this.overtimeHours,
    });

    factory StatisticModel.fromJson(Map<String, dynamic> json) => StatisticModel(
        workingDays: json["working_days"],
        workingHours: json["working_hours"],
        lateArrivals: json["late_arrivals"],
        earlyLeaving: json["early_leaving"],
        leaveRequest: json["leave_request"],
        hoursOff: json["leave_off"]?.toDouble(),
        overtimeRequest: json["overtime_request"],
        overtimeHours: json["overtime_off"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "working_days": workingDays,
        "working_hours": workingHours,
        "late_arrivals": lateArrivals,
        "early_leaving": earlyLeaving,
        "leave_request": leaveRequest,
        "leave_off": hoursOff,
        "overtime_request": overtimeRequest,
        "overtime_off": overtimeHours,
    };
}
