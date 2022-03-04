// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

List<SubCategoryModel> subCategoryModelFromJson(String str) => List<SubCategoryModel>.from(json.decode(str).map((x) => SubCategoryModel.fromJson(x)));

String subCategoryModelToJson(List<SubCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategoryModel {
  SubCategoryModel({
    required this.id,
    required this.name,
    required this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  int categoryId;
  dynamic createdAt;
  dynamic updatedAt;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
