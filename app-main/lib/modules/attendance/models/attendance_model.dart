// To parse this JSON data, do
//
//     final attendanceModel = attendanceModelFromJson(jsonString);

import 'dart:convert';

AttendanceModel attendanceModelFromJson(String str) => AttendanceModel.fromJson(json.decode(str));

String attendanceModelToJson(AttendanceModel data) => json.encode(data.toJson());

class AttendanceModel {
    int? id;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? userId;
    int? companyId;
    int? shiftId;
    DateTime? timeCheckin;
    DateTime? timeCheckout;
    dynamic duration;
    dynamic month;
    dynamic typeCheckin;
    dynamic typeWork;
    int? statusCode;
    dynamic reason;
    ShiftInfo? shiftInfo;
    UserInfo? userInfo;

    AttendanceModel({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.companyId,
        this.shiftId,
        this.timeCheckin,
        this.timeCheckout,
        this.duration,
        this.month,
        this.typeCheckin,
        this.typeWork,
        this.statusCode,
        this.reason,
        this.shiftInfo,
        this.userInfo,
    });

    factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
        id: json["id"],
        createdAt: (json["created_at"] != null) ? DateTime.parse(json["created_at"]) : null,
        updatedAt: (json["updated_at"] != null) ? DateTime.parse(json["updated_at"]) : null,
        userId: json["user_id"],
        companyId: json["company_id"],
        shiftId: json["shift_id"],
        timeCheckin: (json["time_checkin"] != null) ? DateTime.parse(json["time_checkin"]) : null,
        timeCheckout: (json["time_checkout"] != null) ? DateTime.parse(json["time_checkout"]): null,
        duration: json["duration"],
        month: json["month"],
        typeCheckin: json["type_checkin"],
        typeWork: json["type_work"],
        statusCode: json["status_code"],
        reason: json["reason"],
        shiftInfo: ShiftInfo.fromJson(json["shift_info"]),
        userInfo: UserInfo.fromJson(json["user_info"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user_id": userId,
        "company_id": companyId,
        "shift_id": shiftId,
        "time_checkin": timeCheckin?.toIso8601String(),
        "time_checkout": timeCheckout?.toIso8601String(),
        "duration": duration,
        "month": month,
        "type_checkin": typeCheckin,
        "type_work": typeWork,
        "status_code": statusCode,
        "reason": reason,
        "shift_info": shiftInfo?.toJson(),
        "user_info": userInfo?.toJson(),
    };
}

class ShiftInfo {
    int? id;
    dynamic createdAt;
    dynamic updatedAt;
    int? companyId;
    String? name;
    String? timeStart;
    String? timeEnd;
    String? duration;
    int? statusCode;
    int? type;

    ShiftInfo({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.companyId,
        this.name,
        this.timeStart,
        this.timeEnd,
        this.duration,
        this.statusCode,
        this.type,
    });

    factory ShiftInfo.fromJson(Map<String, dynamic> json) => ShiftInfo(
        id: json["id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        companyId: json["company_id"],
        name: json["name"],
        timeStart: json["time_start"],
        timeEnd: json["time_end"],
        duration: json["duration"],
        statusCode: json["status_code"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "company_id": companyId,
        "name": name,
        "time_start": timeStart,
        "time_end": timeEnd,
        "duration": duration,
        "status_code": statusCode,
        "type": type,
    };
}

class UserInfo {
    int? id;
    String? email;
    int? companyId;
    String? employeeCode;
    String? firstName;
    String? lastName;
    dynamic address;
    dynamic statusCode;
    dynamic typeLogin;
    dynamic typeWork;
    dynamic typeShift;
    dynamic departmentId;
    int? roleCode;

    UserInfo({
        this.id,
        this.email,
        this.companyId,
        this.employeeCode,
        this.firstName,
        this.lastName,
        this.address,
        this.statusCode,
        this.typeLogin,
        this.typeWork,
        this.typeShift,
        this.departmentId,
        this.roleCode,
    });

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        email: json["email"],
        companyId: json["company_id"],
        employeeCode: json["employee_code"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        address: json["address"],
        statusCode: json["status_code"],
        typeLogin: json["type_login"],
        typeWork: json["type_work"],
        typeShift: json["type_shift"],
        departmentId: json["department_id"],
        roleCode: json["role_code"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "company_id": companyId,
        "employee_code": employeeCode,
        "first_name": firstName,
        "last_name": lastName,
        "address": address,
        "status_code": statusCode,
        "type_login": typeLogin,
        "type_work": typeWork,
        "type_shift": typeShift,
        "department_id": departmentId,
        "role_code": roleCode,
    };
}
