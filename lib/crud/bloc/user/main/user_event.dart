part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetAll extends UserEvent {}

class DeleteUser extends UserEvent {
  final String id;

  DeleteUser(this.id);
}
