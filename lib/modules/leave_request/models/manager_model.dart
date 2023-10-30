import 'dart:convert';

List<ManagerModel> managerModelFromJson(List<dynamic> str) =>
    List<ManagerModel>.from(str.map((x) => ManagerModel.fromJson(x)));

String managerModelToJson(List<ManagerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ManagerModel {
  int? id;
  String? name;
  int? companyId;
  int? managerId;
  int? statusCode;
  CompanyInfo? companyInfo;
  ManagerInfo? managerInfo;

  ManagerModel({
    this.id,
    this.name,
    this.companyId,
    this.managerId,
    this.statusCode,
    this.companyInfo,
    this.managerInfo,
  });

  factory ManagerModel.fromJson(Map<String, dynamic> json) => ManagerModel(
        id: json["id"],
        name: json["name"],
        companyId: json["company_id"],
        managerId: json["manager_id"],
        statusCode: json["status_code"],
        companyInfo: json["company_info"] != null
            ? CompanyInfo.fromJson(json["company_info"])
            : null,
        managerInfo: json["manager_info"] != null
            ? ManagerInfo.fromJson(json["manager_info"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "company_id": companyId,
        "manager_id": managerId,
        "status_code": statusCode,
        "company_info": companyInfo!.toJson(),
        "manager_info": managerInfo!.toJson(),
      };
}

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
  int? maxDistance;
  String? companyCode;
  DateTime? createdAt;
  dynamic token;
  AdminInfo? adminInfo;

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
    this.token,
    this.adminInfo,
  });

  factory CompanyInfo.fromJson(Map<String, dynamic> json) => CompanyInfo(
        id: json["id"],
        name: json["name"],
        representativeName: json["representative_name"],
        address: json["address"],
        categoryCode: json["category_code"],
        statusCode: json["status_code"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        typeCheckLogin: json["type_check_login"],
        typeWork: json["type_work"],
        maxDistance: json["max_distance"],
        companyCode: json["company_code"],
        createdAt: (json["created_at"] != null)
            ? DateTime.parse(json["created_at"])
            : null,
        token: json["token"],
        adminInfo: (json["admin_info"] != null)
            ? AdminInfo.fromJson(json["admin_info"])
            : null,
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
        "created_at": createdAt!.toIso8601String(),
        "token": token,
        "admin_info": adminInfo!.toJson(),
      };
}

class ManagerInfo {
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
  int? departmentId;
  int? roleCode;

  ManagerInfo({
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

  factory ManagerInfo.fromJson(Map<String, dynamic> json) => ManagerInfo(
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

class AdminInfo {
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
  int? departmentId;
  int? roleCode;

  AdminInfo({
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

  factory AdminInfo.fromJson(Map<String, dynamic> json) => AdminInfo(
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
