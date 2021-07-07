import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml_final/components/main_button_widget.dart';
import 'package:xml_final/components/my_bottom_navigation_bar.dart';
import 'package:xml_final/data/models/user.dart';
import 'package:xml_final/data/repository.dart';
import 'package:xml_final/screens/become_dog_walker_screen/screen.dart';
import 'package:xml_final/screens/walk_requests_screen/screen.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final Repository _repository;
  late final User _user;
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _repository = Repository();
    final prefs = await SharedPreferences.getInstance();
    final _email = prefs.getString('email');
    _user = await _repository.getUser(_email!);

    if (_user.email.isEmpty)
      EasyLoading.showError('Error connecting to server');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      bottomNavigationBar: MyBottomNavigationBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 70),
                    CircleAvatar(
                      radius: 100,
                      foregroundImage: NetworkImage(_user.imageLink),
                    ),
                    SizedBox(height: 10),
                    Text(
                      _user.name,
                      style: CustomTextTheme.appBarHeading,
                    ),
                    Text(
                      _user.email,
                      style: CustomTextTheme.appBarSubheading,
                    ),
                    Spacer(),
                    _user.isDogWalker
                        ? MainButtonWidget(
                            text: 'View Walk Requests',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => WalkRequestsScreen(
                                    walkerName: _user.name,
                                  ),
                                ),
                              );
                            },
                          )
                        : MainButtonWidget(
                            text: 'Become Dog Walker',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BecomeDogWalkerScreen(
                                      username: _user.name),
                                ),
                              );
                            },
                          ),
                    SizedBox(height: 20),
                  ],
                ),
        ),
      ),
    );
  }
}
