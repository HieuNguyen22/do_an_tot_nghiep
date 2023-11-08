import 'dart:io';
import 'package:app_work_log/common/api/response_model.dart';
import 'package:app_work_log/common/utils/extension.dart';
import 'package:app_work_log/oauth2/provider/auth_provider.dart';
import 'package:app_work_log/oauth2/service/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;

class _ApiClient {
  final Dio _dio;

  _ApiClient._(this._dio);

  factory _ApiClient.createClient({
    required String baseUrl,
    List<Interceptor>? interceptors,
  }) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl))
      ..interceptors.addAll([...?interceptors]);
    if (!kReleaseMode) {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }
    return _ApiClient._(dio);
  }
}

enum TypeResponseCode { error, ok }

/// Add option for api header.
class _HeaderInterceptor extends Interceptor {
  final authService = Get.find<AuthService>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /// Add bearer token
    if (authService.token != null) {
      options.headers[HttpHeaders.authorizationHeader] =
          "Bearer ${authService.token}";
    }
    options.contentType = Headers.jsonContentType;
    super.onRequest(options, handler);
  }
}

/// General error handling
class _ErrorInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;
    final code = data["code"];
    final desc = data["desc"];

    if (code == TypeResponseCode.error.name) {
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioErrorType.badResponse,
          error: desc,
        ),
        true,
      );
    }

    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.sendTimeout:
        handler.reject(err.copyWith(error: "DioErrorType.sendTimeout".tr));
        break;
      case DioExceptionType.receiveTimeout:
        handler.reject(err.copyWith(error: "DioErrorType.receiveTimeout".tr));
        break;
      case DioExceptionType.connectionTimeout:
        handler.reject(err.copyWith(error: "DioErrorType.connectTimeout".tr));
        break;
      case DioExceptionType.cancel:
        handler.reject(err.copyWith(error: "DioErrorType.cancel".tr));
        break;
      case DioExceptionType.badResponse:
        handler.reject(err);
        break;
      default:
        handler.reject(err.copyWith(error: "DioErrorType.other".tr));
        break;
    }
  }
}

class _AuthorizedInterceptor extends QueuedInterceptorsWrapper {
  final Dio _dio;
  final authService = Get.find<AuthService>();

  _AuthorizedInterceptor(this._dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Assume 401 stands for token expired
    if (err.response?.statusCode == HttpStatus.unauthorized &&
        authService.token != null) {
      try {
        var options = err.response!.requestOptions;
        // If the token has been updated, repeat directly.
        final accessToken = "Bearer ${authService.token}";
        if (accessToken != options.headers[HttpHeaders.authorizationHeader]) {
          options.headers[HttpHeaders.authorizationHeader] = accessToken;
          try {
            //repeat
            final result = await _dio.fetch(options);
            return handler.resolve(result);
          } catch (e) {
            return handler.next(err);
          }
        } else {
          final refreshToken = authService.refreshToken;
          final result = await AuthProvider().refreshToken(refreshToken);
          final accessTokenNew = result["refreshToken"];
          authService.login(
              token: accessTokenNew, refreshToken: result["refreshToken"]);
          // Update accessToken
          options.headers[HttpHeaders.authorizationHeader] =
              'Bearer $accessTokenNew';
          return handler.resolve(await _dio.fetch(options));
        }
      } on DioException catch (e) {
        if (kDebugMode) {
          print(e);
        }
        authService.logout();
        return handler.reject(e);
      } on Error catch (e) {
        if (kDebugMode) {
          print(e);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    }
    return handler.next(err);
  }
}

abstract class ServiceProvider {
  Dio provider;

  ServiceProvider({required _ApiClient provider}) : provider = provider._dio;

  @protected
  Future getData(Future<Response> request) async {
    try {
      final result = ResponseModel.fromJson((await request).data).data;
      return Future.value(result);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Future.error(e);
    }
  }
}

extension DioErrorExtension on DioException {
  copyWith({
    RequestOptions? requestOptions,
    Response? response,
    DioExceptionType? type,
    dynamic error,
  }) {
    return DioException(
      requestOptions: requestOptions ?? this.requestOptions,
      response: response ?? this.response,
      type: type ?? this.type,
      error: error ?? this.error,
    );
  }
}

final apiProvider =
    _ApiClient.createClient(baseUrl: "BASE_API".env(), interceptors: [
  _HeaderInterceptor(),
  _AuthorizedInterceptor(apiPublishProvider._dio),
  _ErrorInterceptor()
]);

final apiPublishProvider = _ApiClient.createClient(
    baseUrl: "BASE_API".env(),
    interceptors: [_HeaderInterceptor(), _ErrorInterceptor()]);
