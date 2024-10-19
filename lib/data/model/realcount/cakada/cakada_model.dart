class Cakada {
  final int id;
  final String noUrutPaslon;
  final String namaPaslon;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String suara;

  Cakada({
    required this.id,
    required this.noUrutPaslon,
    required this.namaPaslon,
    required this.createdAt,
    required this.updatedAt,
    this.suara = "",
  });

  Cakada copyWith({
    int? id,
    String? noUrutPaslon,
    String? namaPaslon,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? suara,
  }) =>
      Cakada(
        id: id ?? this.id,
        noUrutPaslon: noUrutPaslon ?? this.noUrutPaslon,
        namaPaslon: namaPaslon ?? this.namaPaslon,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        suara: suara ?? this.suara,
      );

  factory Cakada.fromJson(Map<String, dynamic> json) => Cakada(
        id: json["id"],
        noUrutPaslon: json["no_urut_paslon"],
        namaPaslon: json["nama_paslon"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no_urut_paslon": noUrutPaslon,
        "nama_paslon": namaPaslon,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
