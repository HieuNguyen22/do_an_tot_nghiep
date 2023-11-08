import 'dart:convert';

List<ShiftManager> shiftManagerFromJson(List<dynamic> str) => List<ShiftManager>.from(str.map((x) => ShiftManager.fromJson(x)));

String shiftManagerToJson(List<ShiftManager> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShiftManager {
    int? id;
    dynamic createdAt;
    dynamic updatedAt;
    int? companyId;
    String? name;
    String? timeStart;
    String? timeEnd;
    String? duration;
    int? statusCode;
    int? type;

    ShiftManager({
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

    factory ShiftManager.fromJson(Map<String, dynamic> json) => ShiftManager(
        id: json["id"],
        createdAt: json["created_at"] == null ? "" : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? "" : DateTime.parse(json["updated_at"]),
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
        "created_at": createdAt,
        "updated_at": updatedAt,
        "company_id": companyId,
        "name": name,
        "time_start": timeStart,
        "time_end": timeEnd,
        "duration": duration,
        "status_code": statusCode,
        "type": type,
    };
}