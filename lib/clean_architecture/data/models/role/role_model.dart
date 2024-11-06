import '../../../domain/entities/role.dart';

class RoleModel extends Role {
  RoleModel({super.id, required super.kode, required super.name, super.status});

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
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
