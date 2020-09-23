import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_starter_kit/app/constants.dart';
import 'package:flutter_starter_kit/app/models/core/app_provider.dart';
import 'package:flutter_starter_kit/app/models/core/app_store_application.dart';
import 'package:flutter_starter_kit/config/env.dart';
import 'package:flutter_starter_kit/generated/i18n.dart';
import 'package:flutter_starter_kit/utility/log/log.dart';

class AppComponent extends StatefulWidget {
  final AppStoreApplication _application;

  AppComponent(this._application);

  @override
  _AppComponentState createState() => _AppComponentState(_application);
}

class _AppComponentState extends State<AppComponent> {
  final AppStoreApplication _application;

  _AppComponentState(this._application);

  @override
  void dispose() async {
    Log.info('dispose');
    super.dispose();
    await _application.onTerminate();
  }

  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: Env.value.appName,
      locale: Locale('id'),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Constant.PRIMARY_COLOR_LIGHT,
        accentColor: Constant.ACCENT_COLOR_LIGHT,
        brightness: Brightness.light,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        primaryColor: Constant.PRIMARY_COLOR_DARK,
        accentColor: Constant.ACCENT_COLOR_DARK,
        brightness: Brightness.dark,
      ),
      onGenerateRoute: _application.router.generator,
    );

    print('initial core.route = ${app.initialRoute}');

    final appProvider = AppProvider(child: app, application: _application);
    return appProvider;
  }
}
