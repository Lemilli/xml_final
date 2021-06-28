import 'package:flutter/material.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class DogWalkerProfileTab extends StatelessWidget {
  final bool isSelected;
  final String text;

  const DogWalkerProfileTab({required this.isSelected, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 29,
      ),
      decoration: BoxDecoration(
        color: isSelected ? ColorPalette.black : ColorPalette.tab_grey_light,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        text,
        style: isSelected
            ? CustomTextTheme.proflie_selected_tab
            : CustomTextTheme.proflie_unselected_tab,
      ),
    );
  }
}
