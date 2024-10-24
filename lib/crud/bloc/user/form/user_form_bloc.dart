import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user.dart';
import '../../../services/result.dart';
import '../../../services/user/user_service.dart';

part 'user_form_event.dart';
part 'user_form_state.dart';

class UserFormBloc extends Bloc<UserFormEvent, UserFormState> {
  UserFormBloc() : super(UserFormInitial()) {
    on<AddUser>((event, emit) async {
      emit(UserFormLoading());
      try {
        Result<User> res = await UserService().add(event.user);
        if (res.isSuccess) {
          emit(UserFormSuccess("Berhasil"));
        } else {
          emit(UserFormError(res.errorMessage!));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(UserFormError(e.toString()));
      }
    });

    on<UpdateUser>((event, emit) async {
      emit(UserFormLoading());
      try {
        Result<User> res = await UserService().update(event.id, event.user);
        if (res.isSuccess) {
          emit(UserFormSuccess("Berhasil"));
        } else {
          emit(UserFormError(res.errorMessage!));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(UserFormError(e.toString()));
      }
    });
  }
}
