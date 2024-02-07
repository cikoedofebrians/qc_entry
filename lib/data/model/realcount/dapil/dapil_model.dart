import 'dart:convert';

class Dapil {
  final int id;
  final String index;
  final List<String> kelurahan;

  Dapil({
    required this.id,
    required this.index,
    required this.kelurahan,
  });

  Dapil copyWith({
    int? id,
    String? index,
    List<String>? kelurahan,
  }) =>
      Dapil(
        id: id ?? this.id,
        index: index ?? this.index,
        kelurahan: kelurahan ?? this.kelurahan,
      );

  factory Dapil.fromJson(Map<String, dynamic> json) {
    final decodedKelurahan = jsonDecode(json["kelurahan"]);
    List<String> stringsKelurahan = List<String>.from(decodedKelurahan);
    return Dapil(
      id: json["id"],
      index: json["index"],
      kelurahan: stringsKelurahan,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "index": index,
        "kelurahan": kelurahan,
      };
}
