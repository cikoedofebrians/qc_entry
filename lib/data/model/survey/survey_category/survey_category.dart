class SurveyCategory {
  final int id;
  final String surveyTitleId;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  SurveyCategory({
    required this.id,
    required this.surveyTitleId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  SurveyCategory copyWith({
    int? id,
    String? surveyTitleId,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      SurveyCategory(
        id: id ?? this.id,
        surveyTitleId: surveyTitleId ?? this.surveyTitleId,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory SurveyCategory.fromJson(Map<String, dynamic> json) => SurveyCategory(
        id: json["id"],
        surveyTitleId: json["survey_title_id"],
        name: json['name'],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
