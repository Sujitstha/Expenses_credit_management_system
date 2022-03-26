// To parse this JSON data, do
//
//     final totalIncomeModel = totalIncomeModelFromJson(jsonString);

import 'dart:convert';

TotalIncomeModel totalIncomeModelFromJson(String str) => TotalIncomeModel.fromJson(json.decode(str));

String totalIncomeModelToJson(TotalIncomeModel data) => json.encode(data.toJson());

class TotalIncomeModel {
  TotalIncomeModel({
    required this.totalIncome,
  });

  int totalIncome;

  factory TotalIncomeModel.fromJson(Map<String, dynamic> json) => TotalIncomeModel(
        totalIncome: json["totalIncome"],
      );

  Map<String, dynamic> toJson() => {
        "totalIncome": totalIncome,
      };
}
