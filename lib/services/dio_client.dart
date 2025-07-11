import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knsbuy/constants/api_endpoints.dart';
import 'package:knsbuy/models/api_exceptions.dart';
import 'package:knsbuy/models/api_response_model.dart';
import 'package:knsbuy/services/app_session.dart';

final apiProvider = Provider<DioClient>((ref) {
  return DioClient();
});

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio _dio;

  DioClient._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio = Dio(options);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await AppSession.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }

  Dio get client => _dio;

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    required T Function(dynamic data) fromData,
  }) async {
    final response = await _dio.get(path, queryParameters: queryParams);
    return _handleResponse<T>(response, fromData);
  }

  Future<T> post<T>(
    String path, {
    dynamic data,
    required T Function(dynamic data) fromData,
  }) async {
    final response = await _dio.post(path, data: data);
    return _handleResponse<T>(response, fromData);
  }

  T _handleResponse<T>(Response response, T Function(dynamic data) fromData) {
    try {
      final apiResponse = ApiResponse<T>.fromJson(response.data, fromData);

      if (!apiResponse.success) {
        throw ApiException.fromResponse(response.data);
      }

      return apiResponse.data;
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Something went wrong parsing the response.');
    }
  }
}
