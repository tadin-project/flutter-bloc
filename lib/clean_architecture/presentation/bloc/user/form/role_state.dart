part of 'role_bloc.dart';

sealed class RoleState extends Equatable {
  const RoleState();

  @override
  List<Object> get props => [];
}

final class RoleInitial extends RoleState {}

class RoleLoading extends RoleState {}

class RoleLoaded extends RoleState {
  final List<Role> roles;

  const RoleLoaded(this.roles);
}

class RoleError extends RoleState {
  final String message;

  const RoleError(this.message);
}
