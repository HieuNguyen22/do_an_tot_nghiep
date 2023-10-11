// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterCompany _$RegisterCompanyFromJson(Map<String, dynamic> json) =>
    RegisterCompany(
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      employee_code: json['employee_code'] as String?,
      name: json['name'] as String?,
      representative_name: json['representative_name'] as String?,
      address: json['address'] as String?,
      category_code: json['category_code'] as int?,
      status_code: json['status_code'] as int?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      type_check_login: json['type_check_login'] as int?,
      type_work: json['type_work'] as int?,
      max_distance: (json['max_distance'] as num?)?.toDouble(),
      company_code: json['company_code'] as int?,
      email: json['email'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$RegisterCompanyToJson(RegisterCompany instance) =>
    <String, dynamic>{
      'name': instance.name,
      'representative_name': instance.representative_name,
      'employee_code': instance.employee_code,
      'address': instance.address,
      'category_code': instance.category_code,
      'status_code': instance.status_code,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'type_check_login': instance.type_check_login,
      'type_work': instance.type_work,
      'max_distance': instance.max_distance,
      'company_code': instance.company_code,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'password': instance.password,
    };
