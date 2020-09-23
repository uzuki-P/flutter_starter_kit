import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_starter_kit/app/models/core/app_provider.dart';
import 'package:flutter_starter_kit/app/models/core/app_routes.dart';
import 'package:flutter_starter_kit/app/ui/component/btn_gradient.dart';
import 'package:flutter_starter_kit/app/bloc/login/login_bloc.dart';
import 'package:flutter_starter_kit/app/ui/component/toast.dart';
import 'package:flutter_starter_kit/utility/helper/global_helper.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginFormKey = GlobalKey<FormState>();

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  LoginBloc loginBloc;

  @override
  void didChangeDependencies() {
    loginBloc = LoginBloc(application: AppProvider.getApplication(context));

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    loginBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _deviceScreen = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topCenter,
            height: _deviceScreen.height - 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 200,
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: BlocConsumer<LoginBloc, LoginState>(
                    cubit: loginBloc,
                    listener: (_, state) {
                      if (state is LoginSuccess) {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.DASHBOARD,
                        );
                      }

                      if (state is LoginFailure) {
                        showToast(context,
                            'Login Gagal. Harap cek username dan password anda!');
                      }
                    },
                    builder: (ctx, state) {
                      return buildForm(
                        context: ctx,
                        state: state,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForm({
    @required BuildContext context,
    @required LoginState state,
  }) {
    final isProcessing = state is LoginInProgress;
    final theme = Theme.of(context);

    return Form(
      key: loginFormKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            enabled: !isProcessing,
            controller: usernameCtrl,
            decoration: InputDecoration(labelText: 'Username'),
            validator: Helper.fieldIsRequiredValidator,
          ),
          SizedBox(height: 16),
          TextFormField(
            enabled: !isProcessing,
            controller: passwordCtrl,
            obscureText: true,
            validator: Helper.fieldIsRequiredValidator,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 48),
          Container(
            width: 200,
            child: Material(
              shadowColor: !isProcessing ? theme.primaryColor : Colors.grey,
              elevation: 8,
              borderRadius: BorderRadius.circular(32),
              child: BtnGradient(
                isEnabled: !isProcessing,
                label: 'Login',
                onPressed: () {
                  final deviceId = AppProvider.getApplication(context)
                      .sharedPrefHelper
                      .firebaseDeviceId;

                  loginBloc.add(LoginButtonPressed(
                    formState: loginFormKey,
                    username: usernameCtrl.text,
                    password: passwordCtrl.text,
                    deviceId: deviceId,
                  ));
                },
                childPadding: EdgeInsets.symmetric(vertical: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
