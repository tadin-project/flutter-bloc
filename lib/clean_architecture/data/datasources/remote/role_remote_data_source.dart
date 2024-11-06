import '../../../core/error/exception.dart';
import '../../../core/network/dio_client.dart';
import '../../../../crud/models/api_response.dart';
import 'package:dio/dio.dart';

abstract class RoleRemoteDataSource {
  Future<ApiResponse> getAll();
}

class RoleRemoteDataSourceImpl implements RoleRemoteDataSource {
  final DioClient dio;

  const RoleRemoteDataSourceImpl({required this.dio});

  @override
  Future<ApiResponse> getAll() async {
    Response response = await dio.get("/roles");
    if (response.statusCode == 200) {
      return ApiResponse.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
