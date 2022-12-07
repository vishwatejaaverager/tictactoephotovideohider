import 'package:flutter/material.dart';
import 'package:my_project_first/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  static const id = Routes.aboutUs;
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () async {
              await launchUrl(Uri.parse(
                  "https://sites.google.com/view/privacypolicytictoactoe/home"));
            },
            child: const Card(
              child: ListTile(
                title: Text("Privacy Policy"),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await launchUrl(Uri.parse(
                  "https://sites.google.com/view/privacypolicytictoactoe/home"));
            },
            child: const Card(
              child: ListTile(
                title: Text("Terms And Conditions"),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const Card(
              child: ListTile(
                title: Text("Rate us :)"),
                subtitle: Text("ofc u never give 🙂"),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              var url = Uri.parse(
                  "https://docs.google.com/forms/d/e/1FAIpQLSd5D_hbbrx0TjFPyjRfzNGSlQOwKRLbPji7WuHrl1sO6yBRTw/viewform?usp=sf_link");
              launchUrl(url, mode: LaunchMode.externalApplication);
            },
            child: const Card(
              child: ListTile(
                title: Text("Feed back :)"),
                subtitle: Text("ofc u never give 🙂"),
                trailing: Icon(Icons.arrow_right),
              ),
            ),
          ),
          const Card(
            child: ListTile(title: Text("Version 1.0.0")),
          )
        ],
      ),
    );
  }
}
