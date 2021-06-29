import 'package:flutter/material.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class AboutTabWidget extends StatelessWidget {
  final String description;
  final int experience;

  const AboutTabWidget({
    required this.description,
    required this.experience,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Experience",
          style: CustomTextTheme.profile_details_grey.copyWith(
            color: ColorPalette.tab_grey_text,
          ),
        ),
        Text(
          experience.toString() + ' months',
          style: CustomTextTheme.black_bold_17,
        ),
        SizedBox(height: 22),
        Text(
          description,
          style: CustomTextTheme.profile_details_grey.copyWith(
            color: ColorPalette.tab_grey_text,
          ),
        ),
      ],
    );
  }
}
