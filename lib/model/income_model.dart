// To parse this JSON data, do
//
//     final incomeModel = incomeModelFromJson(jsonString);

import 'dart:convert';

IncomeModel incomeModelFromJson(String str) => IncomeModel.fromJson(json.decode(str));

String incomeModelToJson(IncomeModel data) => json.encode(data.toJson());

class IncomeModel {
  IncomeModel({
    required this.data,
  });

  List<Datum> data;

  factory IncomeModel.fromJson(Map<String, dynamic> json) => IncomeModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.date,
    required this.category,
    required this.subcategory,
    required this.amount,
    required this.remarks,
  });

  int id;
  DateTime date;
  String category;
  String subcategory;
  int amount;
  String remarks;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        category: json["category"],
        subcategory: json["subcategory"],
        amount: json["amount"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "category": category,
        "subcategory": subcategory,
        "amount": amount,
        "remarks": remarks,
      };
}
