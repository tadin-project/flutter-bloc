part of 'user_form_bloc.dart';

sealed class UserFormState extends Equatable {
  const UserFormState();

  @override
  List<Object> get props => [];
}

final class UserFormInitial extends UserFormState {}

class UserFormLoading extends UserFormState {}

class UserFormError extends UserFormState {
  final String message;
  const UserFormError(this.message);
}

class UserFormSuccess extends UserFormState {
  final String message;
  const UserFormSuccess(this.message);
}
