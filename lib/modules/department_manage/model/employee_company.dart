import 'dart:convert';

List<EmployeeCompany> employeeCompanyFromJson(List<dynamic> str) => List<EmployeeCompany>.from(str.map((x) => EmployeeCompany.fromJson(x)));

String employeeCompanyToJson(List<EmployeeCompany> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeCompany {
    int? id;
    String? email;
    int? companyId;
    String? employeeCode;
    String? firstName;
    String? lastName;
    String? address;
    String? phoneNumber;
    int? statusCode;
    dynamic typeLogin;
    dynamic typeWork;
    dynamic typeShift;
    int? departmentId;
    int? roleCode;
    DateTime? createdAt;
    DateTime? updatedAt;

    EmployeeCompany({
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

    factory EmployeeCompany.fromJson(Map<String, dynamic> json) => EmployeeCompany(
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
