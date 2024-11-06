import 'package:dartz/dartz.dart';

import '../../core/error/exception.dart';
import '../../core/error/failure.dart';
import '../../core/models/api_response_model.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote/user_remote_data_source.dart';
import '../models/user/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<User>>> getAll() async {
    try {
      ApiResponseModel res = await remoteDataSource.getAll();
      if (res.status) {
        List<User> users =
            (res.data as List).map((json) => UserModel.fromJson(json)).toList();
        return Right(users);
      } else {
        return Left(ServerFailure());
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> add(User user) async {
    try {
      ApiResponseModel res =
          await remoteDataSource.add(UserModel.fromEntity(user));
      if (res.status) {
        User newUser = UserModel.fromJson(res.data);
        return Right(newUser);
      } else {
        return Left(ServerFailure());
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> delete(String id) async {
    try {
      ApiResponseModel res = await remoteDataSource.delete(id);
      if (res.status) {
        return const Right(null);
      } else {
        return Left(ServerFailure());
      }
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> update(User user) async {
    try {
      ApiResponseModel res =
          await remoteDataSource.update(UserModel.fromEntity(user));
      if (res.status) {
        User newUser = UserModel.fromJson(res.data);
        return Right(newUser);
      } else {
        return Left(ServerFailure());
      }
    } on ServerException catch (e) {
      print(e);
      return Left(ServerFailure());
    }
  }
}
