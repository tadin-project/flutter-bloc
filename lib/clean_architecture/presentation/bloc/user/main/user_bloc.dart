import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../domain/entities/user.dart';
import '../../../../domain/usecases/user/delete_user/delete_user_use_case.dart';
import '../../../../domain/usecases/user/delete_user/delete_user_use_case_param.dart';
import '../../../../domain/usecases/user/get_all/get_all_user_use_case.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAllUserUseCase getAllUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  UserBloc({required this.getAllUserUseCase, required this.deleteUserUseCase})
      : super(UserInitial()) {
    on<GetAll>((event, emit) async {
      emit(UserLoading());
      var res = await getAllUserUseCase.call(NoParams());
      res.fold((l) {
        emit(const UserError("Fetching error"));
      }, (r) {
        emit(UserLoaded(r));
      });
    });
    on<Remove>((event, emit) async {
      var res = await deleteUserUseCase(DeleteUserUseCaseParam(id: event.id));
      res.fold((l) {
        emit(const UserError("Delete Error"));
      }, (r) {
        add(GetAll());
      });
    });
  }
}
