// To parse this JSON data, do
//
//     final expensesModel = expensesModelFromJson(jsonString);

import 'dart:convert';

ExpensesModel expensesModelFromJson(String str) => ExpensesModel.fromJson(json.decode(str));

String expensesModelToJson(ExpensesModel data) => json.encode(data.toJson());

class ExpensesModel {
  ExpensesModel({
    required this.data,
  });

  List<Datum> data;

  factory ExpensesModel.fromJson(Map<String, dynamic> json) => ExpensesModel(
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
