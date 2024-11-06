import 'package:dartz/dartz.dart';

import '../entities/user.dart';
import '../../core/error/failure.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getAll();

  Future<Either<Failure, User>> add(User user);

  Future<Either<Failure, User>> update(User user);

  Future<Either<Failure, void>> delete(String id);
}
