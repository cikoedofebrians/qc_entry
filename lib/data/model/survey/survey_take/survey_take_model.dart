import 'dart:convert';

import 'package:qc_entry/data/model/survey/survey_question/survey_question.dart';

SurveyTake surveyTakeFromJson(String str) =>
    SurveyTake.fromJson(json.decode(str));

String surveyTakeToJson(SurveyTake data) => json.encode(data.toJson());

class SurveyTake {
  final List<SurveyQuestion> data;

  SurveyTake({
    required this.data,
  });

  SurveyTake copyWith({
    List<SurveyQuestion>? data,
  }) =>
      SurveyTake(
        data: data ?? this.data,
      );

  factory SurveyTake.fromJson(Map<String, dynamic> json) => SurveyTake(
        data: List<SurveyQuestion>.from(
            json["data"].map((x) => SurveyQuestion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
