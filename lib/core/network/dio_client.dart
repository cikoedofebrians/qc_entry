// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:qc_entry/core/network/endpoints.dart';
import 'package:qc_entry/core/service/token_service.dart';

class DioClient {
  final Dio _dio;
  final TokenService _tokenService;
  const DioClient(this._dio, this._tokenService);

  init() {
    _dio.options = BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      contentType: CONTENT_TYPE,
    );
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(
            headers: {'Authorization': 'Bearer ${_tokenService.getToken()}'}),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      // print(response);

      return response;
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  // POST METHOD
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        queryParameters: queryParameters,
        data: data != null ? FormData.fromMap(data) : null,
        options: Options(
          headers: {
            // "Accept": "application/json",
            // "Content-type": "application/json",
            "authorization": "Bearer ${_tokenService.getToken()}"
          },
          // followRedirects: false,
        ),
        // onSendProgress: onSendProgress,
        // onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // PUT METHOD
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // DELETE METHOD
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
