// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) =>
    ResponseModel(
      data: json['data'],
      code: json['code'] as String?,
      text: json['text'] as String?,
      msg: json['msg'] as String?,
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'code': instance.code,
      'text': instance.text,
      'msg': instance.msg,
      'desc': instance.desc,
    };
