import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_starter_kit/app/models/core/app_store_application.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppStoreApplication application;

  LoginBloc({
    @required this.application,
  }) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      if (!event.formState.currentState.validate()) {
        yield LoginInitial();
      } else {
        try {
          final res = await application.authProvider
              .login(event.username, event.password, event.deviceId);
          if (res.error) {
            print(res.message);
            yield LoginFailure(error: res.message);
          } else {
            final sharedPref = application.sharedPrefHelper;

            await sharedPref.logout();

            final data = res.data;
            final currTime = DateTime.now();
            final newExpiredTime =
                currTime.add(Duration(seconds: data.expiresIn));

            await sharedPref.setAuthToken(data.accessToken);
            await sharedPref.setRefreshToken(data.refreshToken);
            await sharedPref.setUserUid(data.userUid);
            await sharedPref.setExpiredTime(newExpiredTime.toString());

            yield LoginSuccess();
          }
        } on DioError catch (err) {
          print(err);
          yield LoginFailure(error: err.message);
        }
      }
    }
  }
}
