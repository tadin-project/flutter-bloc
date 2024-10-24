import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/role.dart';
import '../../../services/result.dart';
import '../../../services/role/role_service.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc() : super(RoleInitial()) {
    on<GetRole>((event, emit) async {
      emit(RoleLoading());
      try {
        Result<List<Role>> res = await RoleService().getAll();
        if (res.isFailed) {
          emit(RoleError(res.errorMessage!));
        } else {
          emit(RoleLoaded(res.resultValue!));
        }
      } catch (e) {
        emit(RoleError("Error"));
      }
    });
  }
}
