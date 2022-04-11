// To parse this JSON data, do
//
//     final aboutModel = aboutModelFromJson(jsonString);

import 'dart:convert';

AboutModel aboutModelFromJson(String str) => AboutModel.fromJson(json.decode(str));

String aboutModelToJson(AboutModel data) => json.encode(data.toJson());

class AboutModel {
  AboutModel({
    required this.id,
    required this.title,
    required this.description,
  });

  int id;
  String title;
  String description;

  factory AboutModel.fromJson(Map<String, dynamic> json) => AboutModel(
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
