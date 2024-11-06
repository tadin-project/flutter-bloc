import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../entities/user.dart';
import '../../../repositories/user_repository.dart';
import 'add_user_use_case_param.dart';
import 'package:dartz/dartz.dart';

class AddUserUseCase implements Usecase<AddUserUseCaseParam, User> {
  final UserRepository repository;

  const AddUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(AddUserUseCaseParam params) async {
    return await repository.add(params.user);
  }
}
