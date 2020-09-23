import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import 'package:flutter_starter_kit/app/ui/page/login/page.dart';
import 'package:flutter_starter_kit/app/ui/page/splash/page.dart';

Handler simpleHandler(Widget page) {
  return Handler(handlerFunc: (_, __) => page);
}

final withParamRouteHandler = new Handler(handlerFunc: (_, params) {
  String param1 = params['param1']?.first;

  /*
  return new WithParamPage(
    uidPegawai: param1,
  );
   */
  return null;
});

class AppRoutes {
  static const String SPLASH = '/';
  static const String LOGIN = '/login';
  static const String DASHBOARD = '/dashboard';
  
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (
        BuildContext context,
        Map<String, List<String>> params,
      ) {
        print('ROUTE WAS NOT FOUND !!!');
        return null;
      },
    );

    router.define(SPLASH, handler: simpleHandler(SplashPage()));
    router.define(LOGIN, handler: simpleHandler(LoginPage()));
  }
}
