
import 'package:dio/dio.dart';

abstract class IBaseService {
  Future<Response> post({
    required String route,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  });

  Future<Response> get({
    required String route,
    Map<String, dynamic>? parameters,
    Map<String, String>? headers,
  });

  Future<Response> patch({
    required String route,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  });

  Future<Response> delete({
    required String endPoint,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  });

  Future<Response> put({
    required String route,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  });
}
