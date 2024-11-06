part of 'user_form_bloc.dart';

sealed class UserFormEvent extends Equatable {
  const UserFormEvent();

  @override
  List<Object> get props => [];
}

class AddUser extends UserFormEvent {
  final User user;

  const AddUser(this.user);
}

class UpdateUser extends UserFormEvent {
  final User user;

  const UpdateUser(this.user);
}
