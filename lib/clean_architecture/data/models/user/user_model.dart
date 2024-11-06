import '../../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    super.id,
    required super.name,
    required super.email,
    super.password,
    required super.roleId,
    super.roleName,
    super.isVerified,
    super.verifiedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        roleId: json["role_id"],
        roleName: json["role_name"],
        isVerified: json["is_verified"],
        verifiedAt: json["verified_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "role_id": roleId,
        "role_name": roleName,
        "is_verified": isVerified,
        "verified_at": verifiedAt,
      };

  factory UserModel.fromEntity(User data) => UserModel(
        id: data.id,
        name: data.name,
        email: data.email,
        password: data.password,
        roleId: data.roleId,
        roleName: data.roleName,
        isVerified: data.isVerified,
        verifiedAt: data.verifiedAt,
      );
}
