import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../result.dart';
import '../../config/dio_client.dart';
import '../../models/api_response.dart';
import '../../models/role.dart';

class RoleService {
  Future<Result<List<Role>>> getAll() async {
    try {
      Response response = await DioClient().get("/roles");
      ApiResponse res = ApiResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        debugPrint(res.data);
        return Result.success(
            (res.data as List).map((json) => Role.fromJson(json)).toList());
      } else {
        return Result.failed(res.message!);
      }
    } catch (e) {
      return Result.failed(e.toString());
    }
  }
}
