import 'dart:convert';

List<ManagerModel> managerModelFromJson(List<dynamic> str) =>
    List<ManagerModel>.from(str.map((x) => ManagerModel.fromJson(x)));

String managerModelToJson(List<ManagerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ManagerModel {
    int? id;
    String? name;
    String? departName;

    ManagerModel({
        this.id,
        this.name,
        this.departName,
    });

    factory ManagerModel.fromJson(Map<String, dynamic> json) => ManagerModel(
        id: json["id"],
        name: json["name"],
        departName: json["depart_name"] ?? "Admin",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "depart_name": departName,
    };
}