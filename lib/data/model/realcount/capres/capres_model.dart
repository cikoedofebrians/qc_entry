class Capres {
  final int id;
  final String noUrutPaslon;
  final String namaPaslon;
  final String suara;

  Capres({
    required this.id,
    required this.noUrutPaslon,
    required this.namaPaslon,
    this.suara = "",
  });

  Capres copyWith({
    int? id,
    String? noUrutPaslon,
    String? namaPaslon,
    String? suara,
  }) =>
      Capres(
        id: id ?? this.id,
        noUrutPaslon: noUrutPaslon ?? this.noUrutPaslon,
        namaPaslon: namaPaslon ?? this.namaPaslon,
        suara: suara ?? this.suara,
      );

  factory Capres.fromJson(Map<String, dynamic> json) => Capres(
        id: json["id"],
        noUrutPaslon: json["no_urut_paslon"],
        namaPaslon: json["nama_paslon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no_urut_paslon": noUrutPaslon,
        "nama_paslon": namaPaslon,
      };
}
