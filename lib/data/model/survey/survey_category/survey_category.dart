class SurveyCategory {
  final int id;
  final String surveyTitleId;
  final String name;

  SurveyCategory({
    required this.id,
    required this.surveyTitleId,
    required this.name,
  });

  SurveyCategory copyWith({
    int? id,
    String? surveyTitleId,
    String? name,
  }) =>
      SurveyCategory(
        id: id ?? this.id,
        surveyTitleId: surveyTitleId ?? this.surveyTitleId,
        name: name ?? this.name,
      );

  factory SurveyCategory.fromJson(Map<String, dynamic> json) => SurveyCategory(
        id: json["id"],
        surveyTitleId: json["survey_title_id"],
        name: json['nama'],
      );
}
