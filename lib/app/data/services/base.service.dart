import 'dart:developer';
import 'package:dio/dio.dart';
import '../interfaces/base.interface.dart';

class BaseService implements IBaseService {
  BaseService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: '',
          headers: {'Content-Type': 'application/json'},
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 10),
        ),
      ) {
    _setupInterceptors();
  }

  final Dio _dio;

  @override
  Future<Response> delete({
    required String endPoint,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  }) async => await _dio.delete(endPoint);

  @override
  Future<Response> get({
    required String route,
    Map<String, dynamic>? parameters,
    Map<String, String>? headers,
  }) async => await _dio.get(route);

  @override
  Future<Response> patch({
    required String route,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async => await _dio.patch(route, data: body);

  @override
  Future<Response> post({
    required String route,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  }) async => await _dio.post(route, data: body);

  @override
  Future<Response> put({
    required String route,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  }) async => await _dio.put(route, data: body);

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) => handler.next(options),
        onResponse: (response, handler) {
          log(
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
          );
          return handler.next(response);
        },
        onError: (error, handler) {
          log(
            'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
          );
          log('ERROR DATA: ${error.response?.data}');
          return handler.next(error);
        },
      ),
    );
  }
}
