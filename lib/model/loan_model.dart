// To parse this JSON data, do
//
//     final loanModel = loanModelFromJson(jsonString);

import 'dart:convert';

List<LoanModel> loanModelFromJson(String str) => List<LoanModel>.from(json.decode(str).map((x) => LoanModel.fromJson(x)));

String loanModelToJson(List<LoanModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoanModel {
  LoanModel({
    required this.id,
    required this.name,
    required this.address,
    required this.mobile,
    required this.purpose,
    required this.amount,
    required this.dueDate,
    required this.userId,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String address;
  String mobile;
  String purpose;
  String amount;
  DateTime dueDate;
  int userId;
  String remarks;
  DateTime createdAt;
  DateTime updatedAt;

  factory LoanModel.fromJson(Map<String, dynamic> json) => LoanModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        mobile: json["mobile"],
        purpose: json["purpose"],
        amount: json["amount"],
        dueDate: DateTime.parse(json["due_date"]),
        userId: json["user_id"],
        remarks: json["remarks"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "mobile": mobile,
        "purpose": purpose,
        "amount": amount,
        "due_date":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "user_id": userId,
        "remarks": remarks,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
