import 'dart:convert';

List<StaffManage> staffManageFromJson(List<dynamic> str) =>
    List<StaffManage>.from(str.map((x) => StaffManage.fromJson(x)));

String staffManageToJson(List<StaffManage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaffManage {
  int? id;
  String? email;
  int? companyId;
  String? employeeCode;
  dynamic firstName;
  dynamic lastName;
  String? address;
  dynamic phoneNumber;
  dynamic statusCode;
  dynamic typeLogin;
  dynamic typeWork;
  dynamic typeShift;
  dynamic departmentId;
  int? roleCode;

  StaffManage({
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
  });

  factory StaffManage.fromJson(Map<String, dynamic> json) => StaffManage(
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
      };
}
