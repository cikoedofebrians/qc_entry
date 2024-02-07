// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:qc_entry/data/model/survey/survey_category/survey_category.dart';
import 'package:qc_entry/data/model/survey/survey_option/survey_option.dart';

class SurveyQuestion {
  final int id;
  final String? surveyCategoryId;
  final String? index;
  final String? question;
  final QuestionType type;
  final List<Option> options;
  final SurveyCategory surveyCategory;

  SurveyQuestion({
    required this.id,
    required this.surveyCategoryId,
    required this.index,
    required this.question,
    required this.type,
    required this.options,
    required this.surveyCategory,
  });

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) {
    List<Option> optionList = [];
    if (json["options"] != null) {
      final List<Map<String, dynamic>> optionsString =
          jsonDecode(json["options"]).cast<Map<String, dynamic>>().toList();
      for (var i in optionsString) {
        {
          optionList.add(Option.fromJson(i));
        }
      }
    }
    return SurveyQuestion(
        id: json["id"],
        surveyCategoryId: json["survey_category_id"],
        index: json["index"],
        question: json["question"],
        type: typeValues.map[json["type"]]!,
        options: optionList,
        surveyCategory: SurveyCategory.fromJson(json['survey_category']));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "survey_category_id": surveyCategoryId,
        "index": index,
        "question": question,
        "type": typeValues.reverse[type],
        "options": options,
      };
}

enum QuestionType {
  RADIO,
  TEXT,
  TEXTAREA,
  TIME,
  DATE,
  NUMBER,
}

final typeValues = EnumValues({
  "radio": QuestionType.RADIO,
  "text": QuestionType.TEXT,
  "number": QuestionType.NUMBER,
  "textarea": QuestionType.TEXTAREA,
  "time": QuestionType.TIME,
  "date": QuestionType.DATE,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
