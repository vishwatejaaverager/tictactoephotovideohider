import 'package:flutter/material.dart';
import 'package:my_project_first/utils/colors.dart';

class CommonDialog {
  Future<dynamic> showAlert(BuildContext context, String title, String subtitle,
      {Function()? oKonTap,
      Function()? resetOnTap,
      Function()? onLongPressed,
      String? button,
      String? sideButton,
      bool dismiss = false,
      bool show = false}) {
    return showDialog(
      barrierDismissible: dismiss,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(subtitle),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            child: InkWell(
              onTap: resetOnTap,
              child: Text(
                show ? sideButton! : "Reset",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: InkWell(
              onTap: oKonTap,
              onDoubleTap: onLongPressed,
              child: Container(
                height: 50,
                width: 100,
                color: greyColor,
                child: Center(
                  child: Text(
                    show ? button! : "ok",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
