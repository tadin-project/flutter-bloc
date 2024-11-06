import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/user.dart';
import '../../../../domain/usecases/user/add_user/add_user_use_case.dart';
import '../../../../domain/usecases/user/add_user/add_user_use_case_param.dart';
import '../../../../domain/usecases/user/update_user/update_user_use_case.dart';
import '../../../../domain/usecases/user/update_user/update_user_use_case_param.dart';

part 'user_form_event.dart';
part 'user_form_state.dart';

class UserFormBloc extends Bloc<UserFormEvent, UserFormState> {
  final AddUserUseCase addUserUseCase;
  final UpdateUserUseCase updateUserUseCase;

  UserFormBloc({required this.addUserUseCase, required this.updateUserUseCase})
      : super(UserFormInitial()) {
    on<AddUser>((event, emit) async {
      emit(UserFormLoading());
      try {
        var res =
            await addUserUseCase.call(AddUserUseCaseParam(user: event.user));
        res.fold((l) {
          emit(const UserFormError("Gagal menambahkan user"));
        }, (r) {
          emit(const UserFormSuccess("Berhasil menambahkan user"));
        });
      } catch (e) {
        emit(const UserFormError("Gagal menambahkan user"));
      }
    });
    on<UpdateUser>((event, emit) async {
      emit(UserFormLoading());
      try {
        var res = await updateUserUseCase
            .call(UpdateUserUseCaseParam(user: event.user));
        res.fold((l) {
          emit(const UserFormError("Gagal mengupdate user"));
        }, (r) {
          emit(const UserFormSuccess("Berhasil mengupdate user"));
        });
      } catch (e) {
        emit(const UserFormError("Gagal mengupdate user"));
      }
    });
  }
}
