import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/app/models/pojo/_response.dart';
import 'package:flutter_starter_kit/app/models/pojo/response/login_entity.dart';
import 'package:flutter_starter_kit/app/models/pojo/response/refresh_token_entity.dart';
import 'package:flutter_starter_kit/config/env.dart';
import 'package:flutter_starter_kit/utility/http/http_exception.dart';
import 'package:flutter_starter_kit/utility/log/dio_logger.dart';

class AuthProvider {
  static const String TAG = 'AuthProvider';

  static const String _baseUrl = 'https://example.com/api';
  static const String _LOGIN_API = '/user/login';
  static const String _REFRESH_TOKEN_API = '/user/refresh-token';
  static const String _LOGOUT = '/user/logout';

  Dio _dio;

  AuthProvider() {
    BaseOptions dioOptions = BaseOptions()
      ..baseUrl = Env.value.baseUrl ?? AuthProvider._baseUrl;

    _dio = Dio(dioOptions);

    if (EnvType.DEVELOPMENT == Env.value.environmentType ||
        EnvType.STAGING == Env.value.environmentType) {
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
        DioLogger.onSend(TAG, options);
        return options;
      }, onResponse: (Response response) {
        DioLogger.onSuccess(TAG, response);
        return response;
      }, onError: (DioError error) {
        DioLogger.onError(TAG, error);
        return error;
      }));
    }
  }

  Options getHeaderOptionWithoutJwt() {
    return Options(
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
      },
    );
  }

  Future<LoginEntity> login(
      String username, String password, String deviceId) async {
    final formData = FormData.fromMap({
      "username": username,
      "password": password,
      "device_id": deviceId,
    });

    Response response = await _dio.post(
      AuthProvider._LOGIN_API,
      data: formData,
      options: getHeaderOptionWithoutJwt(),
    );
    throwIfNoSuccess(response);
    return LoginEntity().fromJson(response.data);
  }

  Future<SuccessEntity> logout(String uidPegawai, String deviceId) async {
    final formData = FormData.fromMap({
      "uid_pegawai": uidPegawai,
      "device_id": deviceId,
    });

    Response response = await _dio.post(
      AuthProvider._LOGOUT,
      data: formData,
      options: getHeaderOptionWithoutJwt(),
    );
    throwIfNoSuccess(response);
    return SuccessEntity().fromJson(response.data);
  }

  Future<RefreshTokenEntity> refreshToken(String refreshToken) async {
    final formData = FormData.fromMap({
      "refresh_token": refreshToken,
    });

    Response response = await _dio.post(
      AuthProvider._REFRESH_TOKEN_API,
      data: formData,
      options: getHeaderOptionWithoutJwt(),
    );
    throwIfNoSuccess(response);
    return RefreshTokenEntity().fromJson(response.data);
  }

  void throwIfNoSuccess(Response response) {
    if (response.statusCode < 200 || response.statusCode > 299) {
      throw new HttpException(response);
    }
  }
}
