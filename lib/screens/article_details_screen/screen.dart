import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml_final/data/models/article.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailsScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.network(
                article.imageLink,
                errorBuilder: (_, __, ___) => Text("Couldn't load image"),
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
              top: _height * 0.3,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: _width,
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24),
                      Text(
                        article.heading,
                        style: CustomTextTheme.appBarHeading
                            .copyWith(fontSize: 23),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Time to read: ' +
                            article.timeToRead.toString() +
                            ' minutes.',
                        style: CustomTextTheme.appBarSubheading,
                      ),
                      SizedBox(height: 24),
                      Text(
                        article.content,
                        style: CustomTextTheme.profile_details_black,
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
