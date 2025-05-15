import 'dart:io';

import 'package:counter_demo_bloc/helper/session_manager.dart';
import 'package:counter_demo_bloc/network/api_client.dart';
import 'package:counter_demo_bloc/network/connectivity_validator.dart';
import 'package:counter_demo_bloc/network/response_model.dart';
import 'package:counter_demo_bloc/res/constants/messages.dart';
import 'package:counter_demo_bloc/utils/printer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'server_error.dart';

class ApiClientImp implements ApiClient {
  final Dio _dio;
  final SessionManager sessionManager;

  ApiClientImp({required this.sessionManager}) : _dio = Dio() {
    _dio.options
      ..connectTimeout = const Duration(seconds: 60)
      ..receiveTimeout = const Duration(seconds: 60);
  }

  Future<Map<String, String>> _buildHeaders({bool isMultipart = false}) async {
    final token = await sessionManager.getToken();
    debugPrint("Authorization Token::: $token");

    return {
      'Accept': 'application/json',
      if (isMultipart)
        'Content-Type': 'multipart/form-data'
      else
        'Content-Type': 'application/json',
      if (token.isNotEmpty) 'Authorization': 'Token $token',
    };
  }

  Future<ResponseModel?> _safeRequest(Future<Response> future) async {
    if (!await ConnectivityProvider.checkConnectivity()) {
      throw ServerError(503, Messages.NO_INTERNET);
    }
    try {
      final response = await future;
      Printer.printResponse(response);
      if (response.statusCode != null &&
          (response.statusCode! >= 200 && response.statusCode! < 300)) {
        return ResponseModel.fromJson(response.data);
      } else {
        throw ServerError(
          response.statusCode ?? 500,
          response.data['msg'] ?? Messages.SERVER_NOT_RESPONDING,
        );
      }
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e, stack) {
      debugPrint("Unexpected error: $e\n$stack");
      throw ServerError(500, Messages.WRONG);
    }
    return null;
  }

  void _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      throw ServerError(408, Messages.NETWORK_TIMEOUT);
    } else if (e.type == DioExceptionType.badResponse && e.response != null) {
      throw ServerError(
        e.response!.statusCode ?? 500,
        e.response!.data['msg'] ?? Messages.SERVER_NOT_RESPONDING,
      );
    } else if (e.type == DioExceptionType.cancel) {
      throw ServerError(499, Messages.REQUEST_CANCELLED);
    } else {
      throw ServerError(500, Messages.SERVER_NOT_RESPONDING);
    }
  }

  @override
  Future<ResponseModel?> getApi({required String url}) async {
    final headers = await _buildHeaders();
    return _safeRequest(_dio.get(url, options: Options(headers: headers)));
  }

  @override
  Future<ResponseModel?> postApi({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    final headers = await _buildHeaders();
    Printer.printRequest(RequestOptions(path: url, data: body));
    return _safeRequest(
      _dio.post(url, data: body, options: Options(headers: headers)),
    );
  }

  @override
  Future<ResponseModel?> deleteApi({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    final headers = await _buildHeaders();
    return _safeRequest(
      _dio.delete(url, data: body, options: Options(headers: headers)),
    );
  }

  @override
  Future<ResponseModel?> putApi({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    final headers = await _buildHeaders();
    return _safeRequest(
      _dio.put(url, data: body, options: Options(headers: headers)),
    );
  }

  @override
  Future<ResponseModel?> patchApi({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    final headers = await _buildHeaders();
    return _safeRequest(
      _dio.patch(url, data: body, options: Options(headers: headers)),
    );
  }

  @override
  Future<ResponseModel?> multipartApi({
    required String url,
    Map<String, dynamic>? body,
    File? userImage,
    File? documentFront,
    File? documentBack,
    File? document,
  }) async {
    final headers = await _buildHeaders(isMultipart: true);
    final Map<String, dynamic> formDataMap = {
      if (body != null) ...body,
      if (userImage != null)
        'image': await MultipartFile.fromFile(
          userImage.path,
          filename: userImage.path.split('/').last,
        ),
      if (documentFront != null)
        'front_doc': await MultipartFile.fromFile(
          documentFront.path,
          filename: documentFront.path.split('/').last,
        ),
      if (documentBack != null)
        'back_doc': await MultipartFile.fromFile(
          documentBack.path,
          filename: documentBack.path.split('/').last,
        ),
      if (document != null)
        'document': await MultipartFile.fromFile(
          document.path,
          filename: document.path.split('/').last,
        ),
    };

    Printer.prettyPrint(formDataMap.toString());
    return _safeRequest(
      _dio.post(
        url,
        data: FormData.fromMap(formDataMap),
        options: Options(headers: headers),
      ),
    );
  }
}
