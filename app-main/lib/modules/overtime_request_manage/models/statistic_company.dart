import 'dart:convert';

StatisticCompany statisticCompanyFromJson(Map<String, dynamic> str) => StatisticCompany.fromJson(str);

String statisticCompanyToJson(StatisticCompany data) => json.encode(data.toJson());

class StatisticCompany {
    num? workingDays;
    num? workingHours;
    num? lateArrivals;
    num? earlyLeaving;
    num? leaveRequest;
    num? hoursOff;
    num? overtimeRequest;
    num? overtimeHours;

    StatisticCompany({
        this.workingDays,
        this.workingHours,
        this.lateArrivals,
        this.earlyLeaving,
        this.leaveRequest,
        this.hoursOff,
        this.overtimeRequest,
        this.overtimeHours,
    });

    factory StatisticCompany.fromJson(Map<String, dynamic> json) => StatisticCompany(
        workingDays: json["working_days"],
        workingHours: json["working_hours"],
        lateArrivals: json["late_arrivals"],
        earlyLeaving: json["early_leaving"],
        leaveRequest: json["leave_request"],
        hoursOff: json["leave_off"],
        overtimeRequest: json["overtime_request"],
        overtimeHours: json["overtime_off"],
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
