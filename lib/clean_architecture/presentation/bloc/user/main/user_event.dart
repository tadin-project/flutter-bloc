part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetAll extends UserEvent {}

class Remove extends UserEvent {
  final String id;

  const Remove(this.id);
}
