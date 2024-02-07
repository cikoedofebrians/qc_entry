class Survey {
  final int id;
  final String judul;
  final String deskripsi;

  Survey({
    required this.id,
    required this.judul,
    required this.deskripsi,
  });

  Survey copyWith({
    int? id,
    String? judul,
    String? deskripsi,
  }) =>
      Survey(
        id: id ?? this.id,
        judul: judul ?? this.judul,
        deskripsi: deskripsi ?? this.deskripsi,
      );

  factory Survey.fromJson(Map<String, dynamic> json) => Survey(
        id: json["id"],
        judul: json["judul"],
        deskripsi: json['deskripsi'],
      );
}
