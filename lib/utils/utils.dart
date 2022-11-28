import 'package:flutter/material.dart';

final window = WidgetsBinding.instance.window;
Size size = window.physicalSize / window.devicePixelRatio;

appToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

sbh(double h) {
  return SizedBox(
    height: h,
  );
}

sbw(double w) {
  return SizedBox(
    width: w,
  );
}
