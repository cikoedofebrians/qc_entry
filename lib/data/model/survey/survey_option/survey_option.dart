class Option {
  final int? skip;
  final String option;

  Option({
    required this.skip,
    required this.option,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      skip: json["skip"] != null ? json['skip'] : null,
      option: json['option'],
    );
  }
}
