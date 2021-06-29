import 'package:flutter/material.dart';
import 'package:xml_final/components/my_bottom_navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(),
      body: Text('Profile Screen'),
    );
  }
}
