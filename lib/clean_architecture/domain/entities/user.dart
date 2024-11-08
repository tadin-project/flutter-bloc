import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String name;
  final String email;
  final String? password;
  final int roleId;
  final String? roleName;
  final bool? isVerified;
  final String? verifiedAt;

  const User({
    this.id,
    required this.name,
    required this.email,
    this.password,
    required this.roleId,
    this.roleName,
    this.isVerified,
    this.verifiedAt,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    int? roleId,
    String? roleName,
    bool? isVerified,
    String? verifiedAt,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        roleId: roleId ?? this.roleId,
        roleName: roleName ?? this.roleName,
        isVerified: isVerified ?? this.isVerified,
        verifiedAt: verifiedAt ?? this.verifiedAt,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        password,
        roleId,
        roleName,
        isVerified,
        verifiedAt,
      ];
}
