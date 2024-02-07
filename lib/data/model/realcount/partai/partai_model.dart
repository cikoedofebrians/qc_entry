class Partai {
  final int id;
  final String nama;
  final String media;
  final String suara;

  Partai({
    required this.id,
    required this.nama,
    required this.media,
    this.suara = "",
  });

  Partai copyWith({
    int? id,
    String? nama,
    String? media,
    String? suara,
  }) =>
      Partai(
        id: id ?? this.id,
        nama: nama ?? this.nama,
        media: media ?? this.media,
        suara: suara ?? this.suara,
      );

  factory Partai.fromJson(Map<String, dynamic> json) => Partai(
        id: json["id"],
        nama: json["nama"],
        media: json["media"]["original_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "media": media,
      };
}
