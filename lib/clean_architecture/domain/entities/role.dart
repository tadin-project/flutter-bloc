class Role {
  final int? id;
  final String kode;
  final String name;
  final bool? status;

  Role({
    this.id,
    required this.kode,
    required this.name,
    this.status,
  });
}
