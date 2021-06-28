import 'package:flutter/material.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class MainButtonWidget extends StatelessWidget {
  final String text;
  final Function onTap;

  const MainButtonWidget({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: ColorPalette.orangeGradient,
      ),
      child: TextButton(
        onPressed: () => onTap(),
        child: Text(
          text,
          style: CustomTextTheme.buttonTextBold,
        ),
      ),
    );
  }
}
