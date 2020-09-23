import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DarkToast extends StatelessWidget {
  final String message;

  DarkToast(this.message, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black.withAlpha(150),
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}

void showToast(BuildContext context, String message) {
  final fToast = FToast();
  fToast.init(context);
  fToast.showToast(
    child: DarkToast(message),
    toastDuration: Duration(seconds: 3),
  );
}
