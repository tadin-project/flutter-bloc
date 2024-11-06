import '../../core/error/failure.dart';
import '../entities/role.dart';
import 'package:dartz/dartz.dart';

abstract class RoleRepository {
  Future<Either<Failure, List<Role>>> getAll();
}
