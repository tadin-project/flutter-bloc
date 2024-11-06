import 'package:dartz/dartz.dart';

import 'delete_user_use_case_param.dart';
import '../../../repositories/user_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class DeleteUserUseCase implements Usecase<DeleteUserUseCaseParam, void> {
  final UserRepository repository;

  const DeleteUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteUserUseCaseParam params) async {
    return await repository.delete(params.id);
  }
}
