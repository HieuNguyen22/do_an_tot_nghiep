import 'dart:convert';

List<AttendanceCheckInManage> attendanceFromJson(List<dynamic> str) => List<AttendanceCheckInManage>.from(str.map((x) => AttendanceCheckInManage.fromJson(x)));

String attendanceToJson(List<AttendanceCheckInManage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AttendanceCheckInManage {
    int? id;
    dynamic createdAt;
    dynamic updatedAt;
    int? userId;
    int? companyId;
    int? shiftId;
    DateTime? timeCheckin;
    DateTime? timeCheckout;
    String? duration;
    int? month;
    int? typeCheckin;
    int? typeWork;
    int? statusCode;
    String? reason;
    ShiftInfo? shiftInfo;
    UserInfo? userInfo;

    AttendanceCheckInManage({
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

    factory AttendanceCheckInManage.fromJson(Map<String, dynamic> json) => AttendanceCheckInManage(
        id: json["id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        userId: json["user_id"],
        companyId: json["company_id"],
        shiftId: json["shift_id"],
        timeCheckin: DateTime.parse(json["time_checkin"]),
        timeCheckout: json["time_checkout"] == null ? null : DateTime.parse(json["time_checkout"]),
        duration: json["duration"],
        month: json["month"],
        typeCheckin: json["type_checkin"],
        typeWork: json["type_work"],
        statusCode: json["status_code"],
        reason: json["reason"],
        shiftInfo: ShiftInfo.fromJson(json["shift_info"]),
        userInfo: json["user_info"] == null ? null : UserInfo.fromJson(json["user_info"])
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user_id": userId,
        "company_id": companyId,
        "shift_id": shiftId,
        "time_checkin": timeCheckin!.toIso8601String(),
        "time_checkout": timeCheckout!.toIso8601String(),
        "duration": duration,
        "month": month,
        "type_checkin": typeCheckin,
        "type_work": typeWork,
        "status_code": statusCode,
        "reason": reason,
        "shift_info": shiftInfo!.toJson(),
        "user_info": userInfo!.toJson(),
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
    String? code;
    String? firstName;
    String? lastName;
    dynamic address;
    dynamic statusCode;
    dynamic typeLogin;
    dynamic typeWork;
    dynamic typeShift;
    dynamic departmentId;
    dynamic roleCode;

    UserInfo({
        this.id,
        this.email,
        this.companyId,
        this.code,
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
        code: json["code"],
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
        "code": code,
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
