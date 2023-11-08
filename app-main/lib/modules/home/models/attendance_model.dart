// // To parse this JSON data, do
// //
// //     final attendanceModel = attendanceModelFromJson(jsonString);

// import 'dart:convert';

// AttendanceModel attendanceModelFromJson(String str) =>
//     AttendanceModel.fromJson(json.decode(str));

// String attendanceModelToJson(AttendanceModel data) =>
//     json.encode(data.toJson());

// class AttendanceModel {
//   int? id;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? userId;
//   int? companyId;
//   int? shiftId;
//   DateTime? timeCheckin;
//   DateTime? timeCheckout;
//   dynamic duration;
//   dynamic month;
//   dynamic typeCheckin;
//   dynamic typeWork;
//   int? statusCode;
//   dynamic reason;

//   AttendanceModel({
//     this.id,
//     this.createdAt,
//     this.updatedAt,
//     this.userId,
//     this.companyId,
//     this.shiftId,
//     this.timeCheckin,
//     this.timeCheckout,
//     this.duration,
//     this.month,
//     this.typeCheckin,
//     this.typeWork,
//     this.statusCode,
//     this.reason,
//   });

//   factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
//       AttendanceModel(
//         id: json["id"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         userId: json["user_id"],
//         companyId: json["company_id"],
//         shiftId: json["shift_id"],
//         timeCheckin: DateTime.parse(json["time_checkin"]),
//         timeCheckout: (json["time_checkout"] != null) ? DateTime.parse(json["time_checkout"]) : null,
//         duration: json["duration"],
//         month: json["month"],
//         typeCheckin: json["type_checkin"],
//         typeWork: json["type_work"],
//         statusCode: json["status_code"],
//         reason: json["reason"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//         "user_id": userId,
//         "company_id": companyId,
//         "shift_id": shiftId,
//         "time_checkin": timeCheckin?.toIso8601String(),
//         "time_checkout": timeCheckout?.toIso8601String(),
//         "duration": duration,
//         "month": month,
//         "type_checkin": typeCheckin,
//         "type_work": typeWork,
//         "status_code": statusCode,
//         "reason": reason,
//       };
// }
