import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter_starter_kit/config/env.dart';
import 'package:flutter_starter_kit/utility/helper/shared_pref_helper.dart';
import 'package:flutter_starter_kit/utility/http/http_exception.dart';
import 'package:flutter_starter_kit/utility/log/dio_logger.dart';
import 'package:flutter_starter_kit/app/models/pojo/_response.dart';

class WithJwtProvider {
  static const String TAG = 'WithJwtProvider';

  static const String _baseUrl = 'https://example.com/api';

  static const String _PATH = '/path';

  final SharedPrefHelper _sharedPref;

  Dio _dio;
  int _requestRepeatCounter = 0;

  WithJwtProvider(this._sharedPref) {
    BaseOptions dioOptions = BaseOptions()
      ..baseUrl = Env.value.baseUrl ?? WithJwtProvider._baseUrl;

    _dio = Dio(dioOptions);

    if (EnvType.DEVELOPMENT == Env.value.environmentType ||
        EnvType.STAGING == Env.value.environmentType) {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options) async {
            DioLogger.onSend(TAG, options);
            return options;
          },
          onResponse: (Response response) {
            if (response.statusCode == 200) {
              _requestRepeatCounter = 0;
            }

            DioLogger.onSuccess(TAG, response);
            return response;
          },
          onError: (DioError error) async {
            if (error.response.statusCode == 401 &&
                _requestRepeatCounter.isEven) {
              _dio.interceptors.requestLock.lock();
              _dio.interceptors.responseLock.lock();

              // on is logged in, there's refresh token
              await _sharedPref.isLoggedIn();

              _dio.interceptors.requestLock.unlock();
              _dio.interceptors.responseLock.unlock();

              _requestRepeatCounter++;

              return await _dio.request(
                error.request.path,
                queryParameters: error.request.queryParameters,
                data: error.request.data,
                options: Options(
                  method: error.request.method,
                  headers: {
                    HttpHeaders.acceptHeader: 'application/json',
                    HttpHeaders.authorizationHeader:
                        'Bearer ${_sharedPref.authToken ?? ''}',
                  },
                ),
              );
            }
            _requestRepeatCounter = 0;

            DioLogger.onError(TAG, error);
            return error;
          },
        ),
      );
    }
  }

  Options getHeaderOption() {
    return Options(
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.authorizationHeader:
            'Bearer ${_sharedPref.authToken ?? ''}',
      },
    );
  }

  Future<SuccessEntity> postOnPath(String uid) async {
    Response response = await _dio.post(
      WithJwtProvider._PATH + '/' + uid,
      options: getHeaderOption(),
    );

    throwIfNoSuccess(response);
    return SuccessEntity().fromJson(response.data);
  }

  void throwIfNoSuccess(Response response) {
    if (response.statusCode < 200 || response.statusCode > 299) {
      throw new HttpException(response);
    }
  }
}
