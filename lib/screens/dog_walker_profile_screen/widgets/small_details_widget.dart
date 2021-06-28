import 'package:flutter/material.dart';
import 'package:xml_final/data/models/dog_walker.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class SmallDetailsWidget extends StatelessWidget {
  const SmallDetailsWidget({
    required this.dogWalker,
  });

  final DogWalker dogWalker;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dogWalker.price.toString() + r'$',
            style: CustomTextTheme.profile_details_black,
          ),
          Text(
            '/hr',
            style: CustomTextTheme.profile_details_grey,
          ),
          SizedBox(width: 10),
          VerticalDivider(
            color: ColorPalette.grey,
            thickness: 0.5,
          ),
          SizedBox(width: 10),
          Text(
            dogWalker.rating.toString(),
            style: CustomTextTheme.profile_details_black,
          ),
          Icon(
            Icons.star,
            color: ColorPalette.grey_light,
            size: 13,
          ),
          SizedBox(width: 10),
          VerticalDivider(
            color: ColorPalette.grey,
            thickness: 0.5,
          ),
          SizedBox(width: 10),
          Text(
            dogWalker.age.toString(),
            style: CustomTextTheme.profile_details_black,
          ),
          Text(
            ' years',
            style: CustomTextTheme.profile_details_grey,
          ),
          SizedBox(width: 10),
          VerticalDivider(
            color: ColorPalette.grey,
            thickness: 0.5,
          ),
          SizedBox(width: 10),
          Text(
            dogWalker.walksCount.toString(),
            style: CustomTextTheme.profile_details_black,
          ),
          Text(
            ' walks',
            style: CustomTextTheme.profile_details_grey,
          ),
        ],
      ),
    );
  }
}
