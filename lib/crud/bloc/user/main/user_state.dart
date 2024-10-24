part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final List<User> data;

  UserLoaded(this.data);
}

final class UserError extends UserState {
  final String message;

  UserError(this.message);
}
