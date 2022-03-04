// To parse required this JSON data, do
//
//     final todoModel = todoModelFromJson(jsonString);

import 'dart:convert';

TodoModel todoModelFromJson(String str) => TodoModel.fromJson(json.decode(str));

String todoModelToJson(TodoModel data) => json.encode(data.toJson());

class TodoModel {
  TodoModel({
    required this.data,
  });

  List<Datum> data;

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.task,
    required this.createdAt,
  });

  int id;
  String task;
  String createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        task: json["task"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task": task,
        "created_at": createdAt,
      };
}
