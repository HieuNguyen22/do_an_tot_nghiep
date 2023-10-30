// To parse this JSON data, do
//
//     final shiftModel = shiftModelFromJson(jsonString);

import 'dart:convert';

ShiftModel shiftModelFromJson(String str) =>
    ShiftModel.fromJson(json.decode(str));

String shiftModelToJson(ShiftModel data) => json.encode(data.toJson());

class ShiftModel {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? companyId;
  String? name;
  String? timeStart;
  String? timeEnd;
  dynamic duration;
  int? statusCode;
  int? type;

  ShiftModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.companyId,
    this.name,
    this.timeStart,
    this.timeEnd,
    this.duration,
    this.statusCode,
    this.type,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) => ShiftModel(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        companyId: json["company_id"],
        name: json["name"],
        timeStart: json["time_start"],
        timeEnd: json["time_end"],
        duration: json["duration"],
        statusCode: json["status_code"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "company_id": companyId,
        "name": name,
        "time_start": timeStart,
        "time_end": timeEnd,
        "duration": duration,
        "status_code": statusCode,
        "type": type,
      };
}
