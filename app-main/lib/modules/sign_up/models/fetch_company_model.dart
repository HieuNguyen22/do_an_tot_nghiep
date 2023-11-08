import 'package:json_annotation/json_annotation.dart';

part 'fetch_company_model.g.dart';

@JsonSerializable()
class FetchCompanyModel {
  final int? id;
  final String? name;

  FetchCompanyModel(this.id, this.name);

  factory FetchCompanyModel.fromJson(Map<String, dynamic> json) => _$FetchCompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$FetchCompanyModelToJson(this);

}