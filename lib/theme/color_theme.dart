import 'package:flutter/cupertino.dart';

class ColorPalette {
  static const orangeGradient = LinearGradient(
    colors: [Color(0xFFFB724C), Color(0xFFFE904B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const white = Color(0xFFFCFCFC);
  static const black = Color(0xFF2B2B2B);
  static const grey = Color(0xFF7A7A7A);
  static const grey_light = Color(0xFFA1A1A1);
  static const divider_grey_light = Color(0xFFE8E8E8);
  static const tab_grey_light = Color(0xFFF5F5F5);
  static const tab_grey_text = Color(0xFFB0B0B0);
  static const orange = Color(0xFFFFA726);
  static const yellow = Color(0xFFFFCB55);
  static const transparent_grey = Color(0x66C4C4C4);

  static const textFieldBg = Color(0xFFF0F0F0);
  static const textFieldHint = Color(0xFFAEAEB2);
}
