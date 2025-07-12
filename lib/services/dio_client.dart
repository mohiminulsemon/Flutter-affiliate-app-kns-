import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knsbuy/constants/api_endpoints.dart';
import 'package:knsbuy/services/app_session.dart';

final apiProvider = Provider<DioClient>((ref) => DioClient());

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
      validateStatus: (status) {
        // Let all status codes pass through to custom handler
        return true;
      },
    );

    _dio = Dio(options);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await AppSession.getToken();
          if (token != null && token.isNotEmpty) {
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
    dynamic data,
    required T Function(dynamic data) fromData,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParams,
        data: data,
      );
      return _parseResponse<T>(response, fromData);
    } on DioException catch (e) {
      final response = e.response;
      if (e.error is SocketException) {
        throw 'No internet connection';
      }
      if (e.error is DioExceptionType) {
        throw response!.data['message'];
      }

      if (response?.data is Map && response!.data['message'] != null) {
        throw response.data['message'];
      }

      throw 'Request failed. Please try again.';
    } catch (e) {
      throw 'Something went wrong.';
    }
  }

  Future<T> post<T>(
    String path, {
    dynamic data,
    required T Function(dynamic data) fromData,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      return _parseResponse<T>(response, fromData);
    } on DioException catch (e) {
      final response = e.response;

      if (e.error is SocketException) {
        throw 'No internet connection';
      }
      if (e.error is DioExceptionType) {
        throw response!.data['message'];
      }

      if (response?.data is Map && response!.data['message'] != null) {
        debugPrint("thorwing messages ${response.data['message']}-----------");
        throw response.data['message'];
      }

      throw 'Request failed. Please try again.';
    } catch (e) {
      debugPrint("thorwing messages from catch $e-----------");
      throw e.toString();
    }
  }

  T _parseResponse<T>(Response response, T Function(dynamic data) fromData) {
    final data = response.data;

    if (data is Map<String, dynamic>) {
      if (data['success'] == true) {
        return fromData(data['data']);
      } else {
        // ⚠️ Simplest form: just throw the message
        throw data['message'] ?? 'Unknown error occurred.';
      }
    } else {
      throw 'Invalid response format';
    }
  }
}
