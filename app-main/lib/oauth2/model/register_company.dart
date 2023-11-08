import 'package:json_annotation/json_annotation.dart';

part 'register_company.g.dart';

@JsonSerializable()
class RegisterCompany {
  final String? name;
  final String? representative_name;
  final String? employee_code;
  final String? address;
  final int? category_code;
  final int? status_code;
  final double? latitude;
  final double? longitude;
  final int? type_check_login;
  final int? type_work;
  final double? max_distance;
  final int? company_code;
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? password;

  const RegisterCompany({
    this.first_name,
    this.last_name,
    this.employee_code,
    this.name,
    this.representative_name,
    this.address,
    this.category_code,
    this.status_code,
    this.latitude,
    this.longitude,
    this.type_check_login,
    this.type_work,
    this.max_distance,
    this.company_code,
    this.email,
    this.password,
  });

  factory RegisterCompany.fromJson(Map<String, dynamic> json) =>
      _$RegisterCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterCompanyToJson(this);
}
