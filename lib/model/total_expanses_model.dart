// To parse this JSON data, do
//
//     final totalExpensesModel = totalExpensesModelFromJson(jsonString);

import 'dart:convert';

TotalExpensesModel totalExpensesModelFromJson(String str) => TotalExpensesModel.fromJson(json.decode(str));

String totalExpensesModelToJson(TotalExpensesModel data) => json.encode(data.toJson());

class TotalExpensesModel {
  TotalExpensesModel({
    required this.totalExpenses,
  });

  int totalExpenses;

  factory TotalExpensesModel.fromJson(Map<String, dynamic> json) => TotalExpensesModel(
        totalExpenses: json["totalExpenses"],
      );

  Map<String, dynamic> toJson() => {
        "totalExpenses": totalExpenses,
      };
}
