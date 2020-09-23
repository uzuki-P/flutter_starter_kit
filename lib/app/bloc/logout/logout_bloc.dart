import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_starter_kit/app/models/core/app_store_application.dart';

part 'logout_event.dart';

part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  AppStoreApplication application;

  LogoutBloc(this.application) : super(InitialLogoutState());

  @override
  Stream<LogoutState> mapEventToState(LogoutEvent event) async* {
    if (event is DoLogout) {
      yield LogoutLoading();

      try {
        final res = await application.authProvider
            .logout(event.uidPegawai, event.deviceId);

        if (res.error) {
          yield LogoutError(error: res.message);
        } else {
          yield LogoutSuccess();
        }
      } on DioError catch (err) {
        yield LogoutError(error: err.message);
        print(err);
      }
    }
  }
}
