class Caleg {
  final int id;
  final String partaiId;
  final String dapilId;
  final String nama;
  final String noUrut;
  final String suara;

  Caleg({
    required this.id,
    required this.partaiId,
    required this.dapilId,
    required this.nama,
    required this.noUrut,
    this.suara = "",
  });

  Caleg copyWith({
    int? id,
    String? partaiId,
    String? dapilId,
    String? nama,
    String? noUrut,
    String? suara,
  }) =>
      Caleg(
        id: id ?? this.id,
        partaiId: partaiId ?? this.partaiId,
        dapilId: dapilId ?? this.dapilId,
        nama: nama ?? this.nama,
        noUrut: noUrut ?? this.noUrut,
        suara: suara ?? this.suara,
      );

  factory Caleg.fromJson(Map<String, dynamic> json) => Caleg(
        id: json["id"],
        partaiId: json["partai_id"],
        dapilId: json["dapil_id"],
        nama: json["nama"],
        noUrut: json["no_urut"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "partai_id": partaiId,
        "dapil_id": dapilId,
        "nama": nama,
        "no_urut": noUrut,
      };
}
