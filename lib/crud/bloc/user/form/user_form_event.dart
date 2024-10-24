part of 'user_form_bloc.dart';

@immutable
sealed class UserFormEvent {}

class AddUser extends UserFormEvent {
  final User user;

  AddUser(this.user);
}

class UpdateUser extends UserFormEvent {
  final String id;
  final User user;

  UpdateUser(this.id, this.user);
}
