import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class HideSettingWidget extends StatelessWidget {
  final Widget icon;
  final Widget? suffix;
  final String text;
  final Function()? onpressed;
  const HideSettingWidget({
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
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(8),
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), boxShadow: const []),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  icon,
                  sbw(16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Text(
                            text,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )),
                      const Text(
                        "in this pattern",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
              suffix != null ? suffix! : const Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ),
      ),
    );
  }
}
