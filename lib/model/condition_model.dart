// To parse this JSON data, do
//
//     final conditionModel = conditionModelFromJson(jsonString);

import 'dart:convert';

ConditionModel conditionModelFromJson(String str) => ConditionModel.fromJson(json.decode(str));

String conditionModelToJson(ConditionModel data) => json.encode(data.toJson());

class ConditionModel {
  ConditionModel({
    required this.id,
    required this.title,
    required this.description,
  });

  int id;
  String title;
  String description;
  dynamic createdAt;
  dynamic updatedAt;

  factory ConditionModel.fromJson(Map<String, dynamic> json) => ConditionModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
      };
}
