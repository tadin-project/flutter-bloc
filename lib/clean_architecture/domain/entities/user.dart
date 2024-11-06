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
