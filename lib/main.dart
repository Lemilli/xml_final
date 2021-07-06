import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:xml_final/screens/articles_screen/screen.dart';
import 'package:xml_final/screens/home_screen/screen.dart';
import 'package:xml_final/screens/onboarding_screen.dart';
import 'package:xml_final/screens/sign_up_screen/screen.dart';
import 'package:xml_final/screens/walk_planning_screen/screen.dart';
import 'package:xml_final/theme/color_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XML Final',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        primaryColor: ColorPalette.white,
        accentColor: ColorPalette.orange,
      ),
      home: ArticlesScreen(),
    );
  }
}
