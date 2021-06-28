import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:xml_final/screens/sign_up_screen/screen.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;

    final pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
      bodyTextStyle: const TextStyle(fontSize: 14),
      descriptionPadding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      showDoneButton: false,
      showNextButton: false,
      dotsDecorator: DotsDecorator(
        color: Color(0xFFBDBDBD),
        activeColor: Colors.orange,
      ),
      globalFooter: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(gradient: ColorPalette.orangeGradient),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: const Text(
            'Join our community',
            style: CustomTextTheme.buttonTextBold,
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SignUpScreen(),
            ),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Too tired to walk your dog?",
          body: "Let us help you!",
          image: SvgPicture.asset(
            'assets/svg_icons/hello.svg',
            width: _screenWidth * 0.7,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Find dog walkers",
          body:
              "Our community members will walk your dog, and you can focus on your business!",
          image: SvgPicture.asset(
            'assets/svg_icons/good_doggy.svg',
            width: _screenWidth * 0.7,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Find a friend for your dog and yourself",
          body:
              "You can share and explore dog photos and make friends with people like you!",
          image: SvgPicture.asset(
            'assets/svg_icons/group_ppl.svg',
            width: _screenWidth * 0.7,
          ),
          decoration: pageDecoration,
        ),
      ],
    );
  }
}
