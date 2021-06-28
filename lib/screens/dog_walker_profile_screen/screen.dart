import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml_final/data/models/dog_walker.dart';
import 'package:xml_final/screens/dog_walker_profile_screen/widgets/more_details_widget.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class DogWalkerProfileScreen extends StatelessWidget {
  final DogWalker dogWalker;

  const DogWalkerProfileScreen({required this.dogWalker});

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.network(
                dogWalker.imageLink,
                width: double.infinity,
                height: _height * 0.43,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 15,
              top: 20,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  padding: EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorPalette.transparent_grey,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 15,
              top: 20,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  padding: EdgeInsets.all(19),
                  child: SvgPicture.asset(
                    'assets/svg_icons/close.svg',
                    color: ColorPalette.white,
                    width: 14,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 15,
              top: 20,
              child: Container(
                width: 101,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorPalette.transparent_grey,
                ),
                child: Row(
                  children: [
                    Text(
                      "Verified",
                      style: CustomTextTheme.proflie_selected_tab
                          .copyWith(letterSpacing: 0.4),
                    ),
                    SizedBox(width: 4),
                    SvgPicture.asset(
                      'assets/svg_icons/tick_verified.svg',
                      color: ColorPalette.white,
                      width: 12,
                    ),
                  ],
                ),
              ),
            ),
            MoreDetailsWidget(
                height: _height, width: _width, dogWalker: dogWalker)
          ],
        ),
      ),
    );
  }
}
