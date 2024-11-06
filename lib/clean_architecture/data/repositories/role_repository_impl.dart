import '../../core/error/failure.dart';
import '../datasources/remote/role_remote_data_source.dart';
import '../models/role/role_model.dart';
import '../../domain/entities/role.dart';
import '../../domain/repositories/role_repository.dart';
import '../../../crud/models/api_response.dart';
import 'package:dartz/dartz.dart';

class RoleRepositoryImpl implements RoleRepository {
  final RoleRemoteDataSource remoteDataSource;

  const RoleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Role>>> getAll() async {
    try {
      ApiResponse res = await remoteDataSource.getAll();
      return Right(
          (res.data as List).map((json) => RoleModel.fromJson(json)).toList());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
