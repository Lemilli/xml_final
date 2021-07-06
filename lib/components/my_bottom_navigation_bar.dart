import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml_final/screens/articles_screen/screen.dart';
import 'package:xml_final/screens/home_screen/screen.dart';
import 'package:xml_final/screens/profile_screen/screen.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

int navBarIndex = 0;

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: BottomNavigationBar(
        currentIndex: navBarIndex,
        unselectedLabelStyle: CustomTextTheme.unselected_bottom_tab,
        selectedLabelStyle: CustomTextTheme.selected_bottom_tab,
        backgroundColor: Colors.white,
        selectedItemColor: ColorPalette.black,
        unselectedItemColor: ColorPalette.textFieldHint,
        onTap: (index) {
          setState(() {
            navBarIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => ArticlesScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreen()),
              );
              break;
            default:
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg_icons/home.svg',
              color: navBarIndex == 0
                  ? ColorPalette.black
                  : ColorPalette.textFieldHint,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg_icons/document.svg',
              color: navBarIndex == 1
                  ? ColorPalette.black
                  : ColorPalette.textFieldHint,
            ),
            label: 'articles',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg_icons/profile.svg',
              color: navBarIndex == 2
                  ? ColorPalette.black
                  : ColorPalette.textFieldHint,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
