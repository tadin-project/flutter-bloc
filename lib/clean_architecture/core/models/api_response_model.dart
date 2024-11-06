class ApiResponseModel<T> {
  final bool status;
  final String? message;
  final T? data;

  ApiResponseModel({required this.status, this.message, this.data});

  factory ApiResponseModel.fromJson(Map<String, dynamic> json) =>
      ApiResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );
}
