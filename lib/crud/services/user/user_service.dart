import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../result.dart';
import '../../config/dio_client.dart';
import '../../models/api_response.dart';
import '../../models/user.dart';

class UserService {
  final DioClient _dio = DioClient();

  Future<Result<List<User>>> getAll() async {
    try {
      Response response = await _dio.get("/users");
      if (response.statusCode == 200) {
        var res = ApiResponse<List>.fromJson(response.data);
        if (res.status == true) {
          return Result.success(
              res.data!.map((json) => User.fromJson(json)).toList());
        } else {
          return Result.failed(res.message!);
        }
      } else {
        return Result.failed("Gagal mengambil data");
      }
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<Result<User>> add(User user) async {
    try {
      Response response = await _dio.post(
        "/users",
        data: user.toJson(),
      );
      ApiResponse res = ApiResponse.fromJson(response.data);
      debugPrint(res.data.toString());
      if (response.statusCode == 201 && res.status == true) {
        return Result.success(User.fromJson(res.data));
      } else {
        return Result.failed(res.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
      return Result.failed(e.toString());
    }
  }

  Future<Result<User>> update(String id, User user) async {
    try {
      Response response = await _dio.put(
        "/users/$id",
        data: user.toJson(),
      );
      ApiResponse res = ApiResponse.fromJson(response.data);
      debugPrint(res.data.toString());
      if (response.statusCode == 200 && res.status == true) {
        return Result.success(User.fromJson(res.data));
      } else {
        return Result.failed(res.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
      return Result.failed(e.toString());
    }
  }

  Future<Result<String>> delete(String id) async {
    try {
      Response response = await _dio.delete("/users/$id");
      ApiResponse res = ApiResponse.fromJson(response.data);
      if (res.status) {
        return Result.success(res.message ?? "Delete Success");
      } else {
        return Result.failed(res.message!);
      }
    } catch (e) {
      return Result.failed(e.toString());
    }
  }
}
