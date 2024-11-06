import 'package:dio/dio.dart';

import '../../models/user/user_model.dart';
import '../../../core/error/exception.dart';
import '../../../core/models/api_response_model.dart';
import '../../../core/network/dio_client.dart';

abstract class UserRemoteDataSource {
  Future<ApiResponseModel> getAll();

  Future<ApiResponseModel> add(UserModel user);

  Future<ApiResponseModel> update(UserModel user);

  Future<ApiResponseModel> delete(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioClient dio;

  const UserRemoteDataSourceImpl({required this.dio});

  @override
  Future<ApiResponseModel> getAll() async {
    Response response = await dio.get("/users");
    if (response.statusCode == 200) {
      return ApiResponseModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ApiResponseModel> add(UserModel user) async {
    Response response = await dio.post("/users", data: user.toJson());
    if (response.statusCode == 201) {
      return ApiResponseModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ApiResponseModel> update(UserModel user) async {
    print(user);
    Response response = await dio.put("/users/${user.id}", data: user.toJson());
    if (response.statusCode == 200) {
      return ApiResponseModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ApiResponseModel> delete(String id) async {
    Response response = await dio.delete("/users/$id");
    if (response.statusCode == 200) {
      return ApiResponseModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
