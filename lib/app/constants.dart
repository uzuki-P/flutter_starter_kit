import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Constant {
  static const Color PRIMARY_COLOR_LIGHT = const Color(0xff56C1D1);
  static const Color ACCENT_COLOR_LIGHT = const Color(0xffD1D156);

  static const Color PRIMARY_COLOR_DARK = const Color(0xff56C1D1);
  static const Color ACCENT_COLOR_DARK = const Color(0xffD1D156);

  static const double ADD_TASK_ICON_SIZE = 52.0;
  static const double BOTTOM_NAV_HEIGHT = 48 + (ADD_TASK_ICON_SIZE / 2);

  static const BORDER_RADIUS = const BorderRadius.all(Radius.circular(8));
  static const CARD_BORDER_RADIUS = const BorderRadius.all(Radius.circular(24));
  static const CARD_BOX_SHADOW = const BoxShadow(
    spreadRadius: 3,
    blurRadius: 8,
    color: Color(0x14000000),
  );

  static const LinearGradient BTN_PRIMARY_GRADIENT = LinearGradient(
    colors: <Color>[
      Color(0xff28A8E0),
      Color(0xff008A9F),
    ],
    begin: Alignment(-1.0, -4.0),
    end: Alignment(1.0, 4.0),
  );

  static const LinearGradient BTN_PRIMARY_GRADIENT_DISABLED = LinearGradient(
    colors: <Color>[
      Color(0xffC8C8C8),
      Color(0xff959595),
    ],
    begin: Alignment(-1.0, -4.0),
    end: Alignment(1.0, 4.0),
  );
}
