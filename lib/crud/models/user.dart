class User {
  final String? id;
  final String email;
  final String name;
  final int roleId;
  final String? roleName;
  final String? password;
  final bool? isVerified;
  final String? verifiedAt;

  User({
    this.id,
    required this.email,
    required this.name,
    required this.roleId,
    this.roleName,
    this.password,
    this.isVerified,
    this.verifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        roleId: json["role_id"],
        roleName: json["role_name"],
        password: json["password"],
        isVerified: json["is_verified"],
        verifiedAt: json["verified_at"],
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "role_id": roleId,
      "role_name": roleName,
      "password": password,
      "is_verified": isVerified,
      "verified_at": verifiedAt,
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    int? roleId,
    String? roleName,
    String? password,
    bool? isVerified,
    String? verifiedAt,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        roleName: roleName ?? this.roleName,
        password: password ?? this.password,
        isVerified: isVerified ?? this.isVerified,
        verifiedAt: verifiedAt ?? this.verifiedAt,
      );
}
