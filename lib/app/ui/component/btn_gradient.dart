import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/app/constants.dart';

class BtnGradient extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final EdgeInsets childPadding;
  final String label;
  final bool isOutlineType;
  final bool isEnabled;

  static const _defaultChildPadding = EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 12,
  );
  static const _radius = BorderRadius.all(Radius.circular(25));
  static const _splashColor = Color(0xFF4D63C4);

  /// Creates a button widget for GIC call to action.
  /// It wraps with [Expanded] widget.
  ///
  /// Use label for simple button
  ///
  /// OR
  ///
  /// Use child for complex button content
  ///
  /// [isOutlineType = true]  If button is outline only and NO FILL
  ///
  const BtnGradient({
    Key key,
    this.child,
    this.onPressed,
    this.childPadding = _defaultChildPadding,
    this.label,
    this.isOutlineType = false,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _primaryColor = Theme.of(context).primaryColor;
    final _borderStyle =
        Border.all(color: isEnabled ? _primaryColor : Colors.grey, width: 2);

    // check if button is enable and if it's an outline type
    final _gradient = isEnabled
        ? (isOutlineType ? null : Constant.BTN_PRIMARY_GRADIENT)
        : Constant.BTN_PRIMARY_GRADIENT_DISABLED;

    return Container(
      decoration: BoxDecoration(
        gradient: _gradient,
        border: isOutlineType ? _borderStyle : null,
        borderRadius: _radius,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            borderRadius: _radius,
            splashColor: _splashColor,
            onTap: isEnabled ? onPressed : null,
            child: Padding(
              padding: childPadding,
              child: Center(
                child: child ??
                    Text(
                      label,
                      style: TextStyle(
                        color: isOutlineType ? _primaryColor : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
              ),
            )),
      ),
    );
  }
}
