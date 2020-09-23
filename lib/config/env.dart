import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stetho/flutter_stetho.dart';
import 'package:flutter_starter_kit/app/bloc/trace_bloc_observer.dart';

import 'package:flutter_starter_kit/app/models/core/app_component.dart';
import 'package:flutter_starter_kit/app/models/core/app_store_application.dart';

enum EnvType { DEVELOPMENT, STAGING, PRODUCTION, TESTING }

class Env {
  static Env value;

  String appName;
  String baseUrl;
  EnvType environmentType = EnvType.DEVELOPMENT;

  // Database Config
  int dbVersion = 1;
  String dbName;

  Env() {
    value = this;
    _init();
  }

  void _init() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.teal[400]));

    if (EnvType.DEVELOPMENT == environmentType ||
        EnvType.STAGING == environmentType) {
      Bloc.observer = TraceBlocObserver();
      Stetho.initialize();
    }

    var application = AppStoreApplication();
    await application.onCreate();
    runApp(AppComponent(application));
  }
}
