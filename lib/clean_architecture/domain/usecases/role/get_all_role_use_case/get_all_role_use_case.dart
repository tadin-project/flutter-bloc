import 'package:dartz/dartz.dart';

import '../../../entities/role.dart';
import '../../../repositories/role_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetAllRoleUseCase implements Usecase<NoParams, List<Role>> {
  final RoleRepository repository;

  const GetAllRoleUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Role>>> call(NoParams _) async {
    return await repository.getAll();
  }
}
