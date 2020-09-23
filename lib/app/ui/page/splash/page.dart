import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_starter_kit/app/constants.dart';
import 'package:flutter_starter_kit/app/models/core/app_provider.dart';
import 'package:flutter_starter_kit/app/models/core/app_routes.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () async {
      final sharedPref = AppProvider.getApplication(context).sharedPrefHelper;
      if (await sharedPref.isLoggedIn()) {
        Navigator.pushReplacementNamed(context, AppRoutes.DASHBOARD);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.LOGIN);
      }
    });

    return Scaffold(
      backgroundColor: Constant.PRIMARY_COLOR_LIGHT,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SvgPicture.asset('assets/icons/test.svg'),
          ),
        ),
      ),
    );
  }
}
