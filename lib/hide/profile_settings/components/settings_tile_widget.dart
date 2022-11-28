import 'package:flutter/material.dart';

import '../../../utils/utils.dart';




class SettingsTileWidget extends StatelessWidget {
  final Widget icon;
  final Widget? suffix;
  final String text;
  final Function()? onpressed;
  const SettingsTileWidget({
    Key? key,
    required this.text,
    required this.icon,
    this.suffix,
    this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              icon,
              sbw(16),
              Text(text),
            ],
          ),
          suffix != null ? suffix! : const Icon(Icons.keyboard_arrow_right)
        ],
      ),
    );
  }
}
