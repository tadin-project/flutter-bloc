part of 'user_form_bloc.dart';

@immutable
sealed class UserFormState {}

final class UserFormInitial extends UserFormState {}

class UserFormLoading extends UserFormState {}

class UserFormError extends UserFormState {
  final String message;

  UserFormError(this.message);
}

class UserFormSuccess extends UserFormState {
  final String message;

  UserFormSuccess(this.message);
}
