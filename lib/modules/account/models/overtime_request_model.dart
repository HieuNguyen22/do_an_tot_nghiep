// To parse this JSON data, do
//
//     final overtimeRequestModel = overtimeRequestModelFromJson(jsonString);

import 'dart:convert';

OvertimeRequestModel overtimeRequestModelFromJson(String str) => OvertimeRequestModel.fromJson(json.decode(str));

String overtimeRequestModelToJson(OvertimeRequestModel data) => json.encode(data.toJson());

class OvertimeRequestModel {
    int? id;
    int? userId;
    int? companyId;
    int? toApproveId;
    dynamic approveId;
    DateTime? timeStart;
    DateTime? timeEnd;
    String? duration;
    dynamic month;
    int? statusCode;
    int? type;
    String? reason;
    dynamic reasonReject;
    UserInfo? userInfo;

    OvertimeRequestModel({
        this.id,
        this.userId,
        this.companyId,
        this.toApproveId,
        this.approveId,
        this.timeStart,
        this.timeEnd,
        this.duration,
        this.month,
        this.statusCode,
        this.type,
        this.reason,
        this.reasonReject,
        this.userInfo,
    });

    factory OvertimeRequestModel.fromJson(Map<String, dynamic> json) => OvertimeRequestModel(
        id: json["id"],
        userId: json["user_id"],
        companyId: json["company_id"],
        toApproveId: json["to_approve_id"],
        approveId: json["approve_id"],
        timeStart: json["time_start"] == null ? null : DateTime.parse(json["time_start"]),
        timeEnd: json["time_end"] == null ? null : DateTime.parse(json["time_end"]),
        duration: json["duration"],
        month: json["month"],
        statusCode: json["status_code"],
        type: json["type"],
        reason: json["reason"],
        reasonReject: json["reason_reject"],
        userInfo: json["user_info"] == null ? null : UserInfo.fromJson(json["user_info"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "company_id": companyId,
        "to_approve_id": toApproveId,
        "approve_id": approveId,
        "time_start": timeStart?.toIso8601String(),
        "time_end": timeEnd?.toIso8601String(),
        "duration": duration,
        "month": month,
        "status_code": statusCode,
        "type": type,
        "reason": reason,
        "reason_reject": reasonReject,
        "user_info": userInfo?.toJson(),
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
    dynamic phoneNumber;
    int? statusCode;
    dynamic typeLogin;
    dynamic typeWork;
    dynamic typeShift;
    dynamic departmentId;
    int? roleCode;
    DateTime? createdAt;
    DateTime? updatedAt;

    UserInfo({
        this.id,
        this.email,
        this.companyId,
        this.employeeCode,
        this.firstName,
        this.lastName,
        this.address,
        this.phoneNumber,
        this.statusCode,
        this.typeLogin,
        this.typeWork,
        this.typeShift,
        this.departmentId,
        this.roleCode,
        this.createdAt,
        this.updatedAt,
    });

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        email: json["email"],
        companyId: json["company_id"],
        employeeCode: json["employee_code"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        statusCode: json["status_code"],
        typeLogin: json["type_login"],
        typeWork: json["type_work"],
        typeShift: json["type_shift"],
        departmentId: json["department_id"],
        roleCode: json["role_code"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "company_id": companyId,
        "employee_code": employeeCode,
        "first_name": firstName,
        "last_name": lastName,
        "address": address,
        "phone_number": phoneNumber,
        "status_code": statusCode,
        "type_login": typeLogin,
        "type_work": typeWork,
        "type_shift": typeShift,
        "department_id": departmentId,
        "role_code": roleCode,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
