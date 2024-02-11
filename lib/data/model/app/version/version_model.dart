class Version {
  final String message;
  final VersionData data;

  Version({
    required this.message,
    required this.data,
  });

  Version copyWith({
    String? message,
    VersionData? data,
  }) =>
      Version(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory Version.fromJson(Map<String, dynamic> json) => Version(
        message: json["message"],
        data: VersionData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class VersionData {
  final bool latest;
  final String? url;

  VersionData({
    required this.latest,
    required this.url,
  });

  VersionData copyWith({
    bool? latest,
    String? url,
  }) =>
      VersionData(
        latest: latest ?? this.latest,
        url: url ?? this.url,
      );

  factory VersionData.fromJson(Map<String, dynamic> json) => VersionData(
        latest: json["latest"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "latest": latest,
        "url": url,
      };
}
