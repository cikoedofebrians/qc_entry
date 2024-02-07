// To parse this JSON data, do
//
//     final survey = surveyFromJson(jsonString);
import 'dart:convert';

Survey surveyFromJson(String str) => Survey.fromJson(json.decode(str));

String surveyToJson(Survey data) => json.encode(data.toJson());

class Survey {
  final int id;
  final String title;
  final bool isTaken;

  Survey({
    required this.id,
    required this.title,
    required this.isTaken,
  });

  Survey copyWith({
    int? id,
    String? title,
    bool? isTaken,
  }) =>
      Survey(
        id: id ?? this.id,
        title: title ?? this.title,
        isTaken: isTaken ?? this.isTaken,
      );

  factory Survey.fromJson(Map<String, dynamic> json) => Survey(
        id: json["id"],
        title: json["title"],
        isTaken: json["is_taken"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_taken": isTaken,
      };
}
