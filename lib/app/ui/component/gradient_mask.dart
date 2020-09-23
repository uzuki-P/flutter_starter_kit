import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/app/constants.dart';

class GradientMask extends StatelessWidget {
  GradientMask({this.child, this.isEnabled = true});

  final Widget child;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return this.isEnabled
            ? Constant.BTN_PRIMARY_GRADIENT.createShader(bounds)
            : Constant.BTN_PRIMARY_GRADIENT_DISABLED.createShader(bounds);
      },
      child: child,
    );
  }
}
