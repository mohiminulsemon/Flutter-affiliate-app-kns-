class ApiResponse<T> {
  final bool success;
  final String message;
  final int statusCode;
  final T data;
  final List<Map<String, dynamic>>? errorSources;

  ApiResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.data,
    this.errorSources,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic data) fromDataT,
  ) {
    return ApiResponse<T>(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 200,
      data: fromDataT(json['data']),
      errorSources: json['errorSources'] != null
          ? List<Map<String, dynamic>>.from(json['errorSources'])
          : null,
    );
  }
}
