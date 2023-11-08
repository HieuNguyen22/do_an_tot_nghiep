import 'package:json_annotation/json_annotation.dart';

// File response_model
part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  final dynamic data;
  final String? code;
  final String? text;
  final String? msg;
  final String? desc;

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);

  const ResponseModel({
    required this.data,
    this.code,
    this.text,
    this.msg,
    this.desc,
  });

  ResponseModel copyWith({
    dynamic data,
    String? code,
    String? text,
    String? msg,
    String? desc,
  }) {
    return ResponseModel(
      data: data ?? this.data,
      code: code ?? this.code,
      text: text ?? this.text,
      msg: msg ?? this.msg,
      desc: desc ?? this.desc,
    );
  }
}
