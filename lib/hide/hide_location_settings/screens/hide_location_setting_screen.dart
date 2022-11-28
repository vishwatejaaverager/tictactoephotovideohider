import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_project_first/hide/hide_location_settings/components/hide_component_widget.dart';
import 'package:my_project_first/hide/providers/hide_location_provider.dart';
import 'package:my_project_first/routes.dart';
import 'package:my_project_first/utils/utils.dart';
import 'package:provider/provider.dart';

class HiddenLocationSettingScreen extends StatefulWidget {
  static const id = Routes.hideLocationScreen;
  const HiddenLocationSettingScreen({super.key});

  @override
  State<HiddenLocationSettingScreen> createState() =>
      _HiddenLocationSettingScreenState();
}

class _HiddenLocationSettingScreenState
    extends State<HiddenLocationSettingScreen> {
  late HideLocationProvider hideLocationProvider;

  @override
  void initState() {
    hideLocationProvider =
        Provider.of<HideLocationProvider>(context, listen: false);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    hideLocationProvider =
        Provider.of<HideLocationProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HideLocationProvider>(builder: ((_, __, ___) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("where to hide your secret 🙂"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HideSettingWidget(
                text: "Hide Here :)",
                onpressed: () {
                  log("pressed");
                },
                icon: Image.asset(
                  "assets/tac/1.jpg",
                  scale: 8,
                ),
                suffix: Switch(
                  value: __.hideLocation,
                  onChanged: (v) {
                    __.setHideLocation(v);
                  },
                ),
              ),
              HideSettingWidget(
                text: " Hide Here :)",
                icon: Image.asset(
                  "assets/tac/2.jpg",
                  scale: 8,
                ),
                suffix: Switch(
                  value: __.hideLocation1,
                  onChanged: (v) {
                    __.setHideLocation1(v);
                  },
                ),
              ),
              HideSettingWidget(
                text: " Hide Here :)",
                icon: Image.asset(
                  "assets/tac/3.jpg",
                  scale: 8,
                ),
                suffix: Switch(
                  value: __.hideLocation2,
                  onChanged: (v) {
                    __.setHideLocation2(v);
                  },
                ),
              ),
              HideSettingWidget(
                text: " Hide Here :) ",
                icon: Image.asset(
                  "assets/tac/4.jpg",
                  scale: 8,
                ),
                suffix: Switch(
                  value: __.hideLocation3,
                  onChanged: (v) {
                    __.setHideLocation3(v);
                    if (__.maxLimit == 3) {
                      appToast(context, "message");
                    }
                  },
                ),
              ),
              HideSettingWidget(
                text: "Hide Here :)",
                icon: Image.asset(
                  "assets/tac/5.jpg",
                  scale: 8,
                ),
                suffix: Switch(
                  value: __.hideLocation4,
                  onChanged: (v) {
                    __.setHideLocation4(v);
                  },
                ),
              ),
              HideSettingWidget(
                text: "  Hide Here :)",
                icon: Image.asset(
                  "assets/tac/6.jpg",
                  scale: 8,
                ),
                suffix: Switch(
                  value: __.hideLocation5,
                  onChanged: (v) {
                    __.setHideLocation5(v);
                  },
                ),
              ),
              HideSettingWidget(
                text: "Hide Here :)",
                icon: Image.asset(
                  "assets/tac/7.jpg",
                  scale: 8,
                ),
                suffix: Switch(
                  value: __.hideLocation6,
                  onChanged: (v) {
                    __.setHideLocation6(v);
                  },
                ),
              ),
              HideSettingWidget(
                text: "Hide Here :)",
                icon: Image.asset(
                  "assets/tac/8.jpg",
                  scale: 8,
                ),
                suffix: Switch(
                  value: __.hideLocation7,
                  onChanged: (v) {
                    __.setHideLocation7(v);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }));
  }
}
