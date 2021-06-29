import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xml_final/components/main_button_widget.dart';
import 'package:xml_final/data/models/dog_walker.dart';
import 'package:xml_final/screens/dog_walker_profile_screen/widgets/reviews_tab_widget.dart';
import 'package:xml_final/screens/dog_walker_profile_screen/widgets/small_details_widget.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

import 'about_tab_widget.dart';
import 'dog_walkers_profile_tab.dart';

class MoreDetailsWidget extends StatefulWidget {
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
  _MoreDetailsWidgetState createState() => _MoreDetailsWidgetState();
}

class _MoreDetailsWidgetState extends State<MoreDetailsWidget> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget._height * 0.3,
      child: Container(
        width: widget._width,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ColorPalette.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Center(
              child: Text(
                widget.dogWalker.name,
                style: CustomTextTheme.appBarHeading.copyWith(fontSize: 28),
              ),
            ),
            SizedBox(height: 10),
            SmallDetailsWidget(dogWalker: widget.dogWalker),
            SizedBox(height: 22),
            Divider(
              thickness: 1.5,
              color: ColorPalette.divider_grey_light,
            ),
            SizedBox(height: 14),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTabIndex = 0;
                    });
                  },
                  child: DogWalkerProfileTab(
                    isSelected: selectedTabIndex == 0,
                    text: "About",
                  ),
                ),
                SizedBox(width: 14),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTabIndex = 1;
                    });
                  },
                  child: DogWalkerProfileTab(
                    isSelected: selectedTabIndex == 1,
                    text: "Reviews",
                  ),
                ),
              ],
            ),
            SizedBox(height: 22),
            AboutTabWidget(
              description: widget.dogWalker.description,
              experience: widget.dogWalker.experience,
            ),
            // selectedTabIndex == 0
            //     ? AboutTabWidget(
            //         description: widget.dogWalker.description,
            //         experience: widget.dogWalker.experience,
            //       )
            //     : ReviewsTabWidget(name: widget.dogWalker.name),
            SizedBox(height: 22),
            MainButtonWidget(
              text: 'Check Schedule',
              onTap: () {
                //TODO IMPLEMENT CHAT?
              },
            ),
          ],
        ),
      ),
    );
  }
}
