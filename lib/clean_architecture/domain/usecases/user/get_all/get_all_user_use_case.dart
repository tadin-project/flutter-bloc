import 'package:dartz/dartz.dart';

import '../../../entities/user.dart';
import '../../../repositories/user_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';

class GetAllUserUseCase implements Usecase<NoParams, List<User>> {
  final UserRepository repository;

  GetAllUserUseCase(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(NoParams _) async {
    return await repository.getAll();
  }
}
