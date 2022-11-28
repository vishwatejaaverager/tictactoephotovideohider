import 'package:flutter/material.dart';
import 'package:my_project_first/hide/providers/hide_location_provider.dart';
import 'package:my_project_first/hide/providers/lock_screen_provider.dart';
import 'package:my_project_first/routes.dart';
import 'package:my_project_first/utils/colors.dart';
import 'package:my_project_first/utils/utils.dart';
import 'package:provider/provider.dart';

class LockSettingScreen extends StatefulWidget {
  static const id = Routes.lockScreenSetting;
  const LockSettingScreen({super.key});

  @override
  State<LockSettingScreen> createState() => _LockSettingScreenState();
}

class _LockSettingScreenState extends State<LockSettingScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: size.width / 2,
              margin: const EdgeInsets.all(16),
              child: TextFormField(
                  controller: _controller,
                  onChanged: (v) {},
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusColor: greyColor,
                    fillColor: greyColor,
                    hintText: 'change passcode',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )),
            ),
          ),
          sbh(12),
          TextButton(
              onPressed: () {
                if (_controller.text.length != 4) {
                  appToast(context, "passcode must be only 4 digits :)");
                } else if (_controller.text.length == 4) {
                  final String pass = _controller.text;
                  Provider.of<LockScreenProvider>(context, listen: false)
                      .setPasscode(pass);
                  Navigator.pop(context);
                  appToast(context, "succesfully changed pass to $pass");
                }
              },
              child: const Text(
                'save',
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
}
