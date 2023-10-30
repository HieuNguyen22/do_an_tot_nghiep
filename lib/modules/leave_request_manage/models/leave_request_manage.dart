import 'dart:convert';

List<LeaveRequestManage> leaveRequestManageFromJson(List<dynamic> str) => List<LeaveRequestManage>.from(str.map((x) => LeaveRequestManage.fromJson(x)));

String leaveRequestManageToJson(List<LeaveRequestManage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LeaveRequestManage {
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
    dynamic reason;
    dynamic reasonReject;
    UserInfo? userInfo;

    LeaveRequestManage({
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

    factory LeaveRequestManage.fromJson(Map<String, dynamic> json) => LeaveRequestManage(
        id: json["id"],
        userId: json["user_id"],
        companyId: json["company_id"],
        toApproveId: json["to_approve_id"],
        approveId: json["approve_id"],
        timeStart: DateTime.parse(json["time_start"]),
        timeEnd: DateTime.parse(json["time_end"]),
        duration: json["duration"],
        month: json["month"],
        statusCode: json["status_code"],
        type: json["type"],
        reason: json["reason"],
        reasonReject: json["reason_reject"],
        userInfo: UserInfo.fromJson(json["user_info"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "company_id": companyId,
        "to_approve_id": toApproveId,
        "approve_id": approveId,
        "time_start": timeStart!.toIso8601String(),
        "time_end": timeEnd!.toIso8601String(),
        "duration": duration,
        "month": month,
        "status_code": statusCode,
        "type": type,
        "reason": reason,
        "reason_reject": reasonReject,
        "user_info": userInfo!.toJson(),
    };
}

class UserInfo {
    int? id;
    String? email;
    int? companyId;
    String? employeeCode;
    String? firstName;
    String? lastName;
    String? address;
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