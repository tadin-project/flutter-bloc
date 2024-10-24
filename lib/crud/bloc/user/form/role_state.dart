part of 'role_bloc.dart';

sealed class RoleState {}

final class RoleInitial extends RoleState {}

class RoleLoading extends RoleState {}

class RoleLoaded extends RoleState {
  final List<Role> roles;

  RoleLoaded(this.roles);
}

class RoleError extends RoleState {
  final String message;

  RoleError(this.message);
}
