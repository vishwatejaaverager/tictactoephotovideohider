import 'package:flutter/material.dart';

import '../../../utils/utils.dart';



class SettingHeadingTile extends StatelessWidget {
  final String text;
  const SettingHeadingTile({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: size.width,
      
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
