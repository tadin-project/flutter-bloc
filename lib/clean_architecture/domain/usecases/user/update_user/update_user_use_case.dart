import 'package:dartz/dartz.dart';

import 'update_user_use_case_param.dart';
import '../../../entities/user.dart';
import '../../../repositories/user_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class UpdateUserUseCase implements Usecase<UpdateUserUseCaseParam, User> {
  final UserRepository repository;

  UpdateUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(UpdateUserUseCaseParam params) async {
    return await repository.update(params.user);
  }
}
