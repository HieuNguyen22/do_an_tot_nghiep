// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:app_work_log/modules/home/models/shift_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class CompanyInfo {
  int? id;
  String? name;
  String? representativeName;
  String? address;
  int? categoryCode;
  int? statusCode;
  double? latitude;
  double? longitude;
  int? typeCheckLogin;
  int? typeWork;
  double? maxDistance;
  String? companyCode;
  dynamic createdAt;
  UserModel? adminInfo;

  CompanyInfo({
    this.id,
    this.name,
    this.representativeName,
    this.address,
    this.categoryCode,
    this.statusCode,
    this.latitude,
    this.longitude,
    this.typeCheckLogin,
    this.typeWork,
    this.maxDistance,
    this.companyCode,
    this.createdAt,
    this.adminInfo,
  });

  factory CompanyInfo.fromJson(Map<String, dynamic> json) => CompanyInfo(
        id: json["id"],
        name: json["name"] ?? "",
        representativeName: json["representative_name"] ?? "",
        address: json["address"] ?? "",
        categoryCode: json["category_code"],
        statusCode: json["status_code"],
        latitude:
            (json["latitude"] != null) ? json["latitude"].toDouble() : 0.0,
        longitude:
            (json["longitude"] != null) ? json["longitude"].toDouble() : 0.0,
        typeCheckLogin: json["type_check_login"],
        typeWork: json["type_work"],
        maxDistance: json["max_distance"]?.toDouble(),
        companyCode: json["company_code"],
        createdAt: json["created_at"],
        adminInfo: UserModel.fromJson(json["admin_info"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "representative_name": representativeName,
        "address": address,
        "category_code": categoryCode,
        "status_code": statusCode,
        "latitude": latitude,
        "longitude": longitude,
        "type_check_login": typeCheckLogin,
        "type_work": typeWork,
        "max_distance": maxDistance,
        "company_code": companyCode,
        "created_at": createdAt,
        "admin_info": adminInfo?.toJson(),
      };
}

class UserModel {
  int? id;
  String? email;
  int? companyId;
  String? employeeCode;
  String? firstName;
  String? lastName;
  dynamic address;
  dynamic phoneNumber;
  dynamic statusCode;
  dynamic typeLogin;
  dynamic typeWork;
  dynamic typeShift;
  dynamic departmentId;
  dynamic shiftId;
  int? roleCode;
  CompanyInfo? companyInfo;
  dynamic departmentInfo;
  ShiftModel? shiftInfo;

  UserModel({
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
    this.shiftId,
    this.roleCode,
    this.companyInfo,
    this.departmentInfo,
    this.shiftInfo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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
        shiftId: json["shift_id"],
        roleCode: json["role_code"],
        companyInfo: json["company_info"] == null
            ? null
            : CompanyInfo.fromJson(json["company_info"]),
        departmentInfo: json["department_info"],
        shiftInfo: json["shift_info"] == null
            ? null
            : ShiftModel.fromJson(json["shift_info"]),
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
        "shift_id": shiftId,
        "role_code": roleCode,
        "company_info": companyInfo?.toJson(),
        "department_info": departmentInfo,
        "shift_info": shiftInfo,
      };
}
