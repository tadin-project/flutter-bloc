import '../../../../core/usecase/usecase.dart';
import '../../../../domain/usecases/role/get_all_role_use_case/get_all_role_use_case.dart';
import '../../../../injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/role.dart';
import 'package:equatable/equatable.dart';

part 'role_event.dart';
part 'role_state.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  final GetAllRoleUseCase getAllRoleUseCase;

  RoleBloc({required this.getAllRoleUseCase}) : super(RoleInitial()) {
    on<GetRoles>((event, emit) async {
      emit(RoleLoading());
      var res = await getAllRoleUseCase.call(sl<NoParams>());
      res.fold((l) {
        emit(const RoleError("Gagal ambil role"));
      }, (r) {
        emit(RoleLoaded(r));
      });
    });
  }
}
