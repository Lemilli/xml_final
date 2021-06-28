import 'package:flutter/material.dart';
import 'package:xml_final/components/main_button_widget.dart';
import 'package:xml_final/data/models/dog_walker.dart';
import 'package:xml_final/screens/dog_walker_profile_screen/widgets/small_details_widget.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

import 'dog_walkers_profile_tab.dart';

class MoreDetailsWidget extends StatelessWidget {
  const MoreDetailsWidget({
    required double height,
    required double width,
    required this.dogWalker,
  })  : _height = height,
        _width = width;

  final double _height;
  final double _width;
  final DogWalker dogWalker;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _height * 0.3,
      child: Container(
        width: _width,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            Text(
              dogWalker.name,
              style: CustomTextTheme.appBarHeading.copyWith(fontSize: 28),
            ),
            SizedBox(height: 10),
            SmallDetailsWidget(dogWalker: dogWalker),
            SizedBox(height: 22),
            Divider(
              thickness: 1.5,
              color: ColorPalette.divider_grey_light,
            ),
            SizedBox(height: 22),
            Row(
              children: [
                DogWalkerProfileTab(isSelected: true, text: "About"),
                SizedBox(width: 22),
                DogWalkerProfileTab(isSelected: false, text: "Reviews"),
              ],
            ),
            SizedBox(height: 22),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Experience",
                style: CustomTextTheme.profile_details_grey.copyWith(
                  color: ColorPalette.tab_grey_text,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'SOME EXP LOL',
                style: CustomTextTheme.black_bold_17,
              ),
            ),
            SizedBox(height: 22),
            Text(
              dogWalker.description,
              style: CustomTextTheme.profile_details_grey.copyWith(
                color: ColorPalette.tab_grey_text,
              ),
            ),
            SizedBox(height: 22),
            MainButtonWidget(
              text: 'Check Schedule',
              onTap: () {
                //TODO IMPLEMENT CHAT?
              },
            ),
            SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}
