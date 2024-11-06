part of 'role_bloc.dart';

sealed class RoleEvent extends Equatable {
  const RoleEvent();

  @override
  List<Object> get props => [];
}

class GetRoles extends RoleEvent {}
