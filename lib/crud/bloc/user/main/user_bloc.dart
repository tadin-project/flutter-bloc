import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user.dart';
import '../../../services/result.dart';
import '../../../services/user/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GetAll>((event, emit) async {
      emit(UserLoading());
      Result res = await UserService().getAll();
      if (res.isSuccess) {
        emit(UserLoaded(res.resultValue));
      } else {
        emit(UserError(res.errorMessage ?? "Error"));
      }
    });
    on<DeleteUser>((event, emit) async {
      Result res = await UserService().delete(event.id);
      if (res.isSuccess) {
        add(GetAll());
      } else {
        emit(UserError(res.errorMessage ?? "Error"));
      }
    });
  }
}
