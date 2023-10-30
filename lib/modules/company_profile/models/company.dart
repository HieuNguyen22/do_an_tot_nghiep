import 'dart:convert';

CompanyModel companyModelFromJson(Map<String, dynamic> str) => CompanyModel.fromJson(str);

String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
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
    int? numberStaff;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic token;
    AdminInfo? adminInfo;

    CompanyModel({
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
        this.numberStaff,
        this.createdAt,
        this.updatedAt,
        this.token,
        this.adminInfo,
    });

    factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
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
        numberStaff: json["number_staff"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        token: json["token"],
        adminInfo: AdminInfo.fromJson(json["admin_info"]),
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
        "number_staff": numberStaff,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "token": token,
        "admin_info": adminInfo!.toJson(),
    };
}

class AdminInfo {
    int? id;
    String? email;
    int? companyId;
    dynamic employeeCode;
    dynamic firstName;
    dynamic lastName;
    dynamic address;
    dynamic phoneNumber;
    dynamic statusCode;
    dynamic typeLogin;
    dynamic typeWork;
    dynamic typeShift;
    dynamic departmentId;
    dynamic roleCode;
    DateTime? createdAt;
    DateTime? updatedAt;

    AdminInfo({
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

    factory AdminInfo.fromJson(Map<String, dynamic> json) => AdminInfo(
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
    };
}
