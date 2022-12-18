// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:gif_view/gif_view.dart';
import 'package:my_project_first/routes.dart';
import 'package:my_project_first/splash_screen.dart';
import 'package:my_project_first/tic_tac_toe/screens/tic_tac_toe_screen.dart';

import 'package:my_project_first/utils/utils.dart';

class OnBoardingScreen extends StatelessWidget {
  static const id = Routes.onBoardingScreen;
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingSlider(
        finishButtonColor: Colors.black,
        headerBackgroundColor: const Color(0xff232428),
        finishButtonText: 'Hide :)',
        skipTextButton: const Text(''),
        trailing: const Text(''),
        onFinish: () {
          Navigator.pushNamedAndRemoveUntil(
              context, SplashScreen.id, (route) => false);
        },
        speed: 1.8,
        background: [
          Container(
            height: size.height,
            width: size.width,
            color: const Color(0xff232428),
          ),
          Container(
            height: size.height,
            width: size.width,
            color: const Color(0xff232428),
          ),
          Container(
            height: size.height,
            width: size.width,
            color: const Color(0xff232428),
          ),
          Container(
            height: size.height,
            width: size.width,
            color: const Color(0xff232428),
          ),
          Container(
            height: size.height,
            width: size.width,
            color: const Color(0xff232428),
          )
        ],
        totalPage: 5,
        pageBodies: [
          OnBoardComponent(
            image: Image.asset(
              'assets/profile/show_image.png',
              height: size.height / 1.8,
            ),
            text:
                "Make x win in first row or second row or third row.\n by default 3 rows are set as hide locations",
          ),
          OnBoardComponent(
            image: Image.asset(
              'assets/profile/show_image2.jpg',
              height: size.height / 1.54,
            ),
            text:
                "Normal click on ''ok'' would continue the game. \n Double tap on  on it will redirect u to lockscreen \n ",
          ),
          OnBoardComponent(
            image: Image.asset(
              'assets/profile/show_image3.jpg',
              height: size.height / 1.54,
            ),
            text:
                "By default its 1234. You can change passcode in the settings :)",
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "DISCLAIMER",
                style: TextStyle(fontSize: 24),
              ),
              Container(
                  margin: const EdgeInsets.all(16),
                  width: size.width,
                  child: const Center(
                      child: Text(
                    "By Uninstalling the app will delete your images and videos.Due to security issues, the images which you hide will not dissapear from your gallery :(",
                    style: TextStyle(fontSize: 16),
                  ))),
            ],
          ),
          Column(
            children: [
              GifView.asset(
                'assets/profile/on_board.gif',
                height: size.height / 1.6,
              ),
              Container(
                  margin: const EdgeInsets.all(16),
                  width: size.width,
                  child: const Text(
                      "You hate Adss me too ! ;)This  App  is completely add free ! :) \n No in app purchases :) please to watch the video before u continue ! :)"))
            ],
          ),
        ],
      ),
    );
  }
}

class OnBoardComponent extends StatelessWidget {
  final String text;
  final Widget image;
  const OnBoardComponent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          child: image,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
        sbh(16)
      ],
    );
  }
}
