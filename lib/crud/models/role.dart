class Role {
  final int? id;
  final String kode;
  final String name;
  final bool? status;

  Role({this.id, required this.kode, required this.name, this.status});

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        kode: json["kode"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "name": name,
        "status": status,
      };
}
