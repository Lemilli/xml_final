import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:xml_final/components/main_button_widget.dart';
import 'package:xml_final/data/models/user.dart';
import 'package:xml_final/data/repository.dart';
import 'package:xml_final/screens/home_screen/screen.dart';
import 'package:xml_final/screens/sign_up_screen/widgets/sign_up_text_forms.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final repository = Repository();

  final formKey = GlobalKey<FormState>();
  bool isSignUp = true;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void toggleView() {
    setState(() {
      isSignUp = !isSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Let's start here",
                    style: CustomTextTheme.appBarHeading,
                    textAlign: TextAlign.left,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Fill in your details to begin",
                    style: CustomTextTheme.appBarSubheading,
                    textAlign: TextAlign.left,
                  ),
                ),
                SignUpTextForms(
                  isSignUp: isSignUp,
                  formKey: formKey,
                  emailController: _emailController,
                  nameController: _nameController,
                  passwordController: _passwordController,
                ),
                SizedBox(height: 22),
                MainButtonWidget(
                  text: isSignUp ? "Sign up" : "Log in",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      EasyLoading.show(status: 'loading...');
                      final response = isSignUp
                          ? await repository.postUser(
                              _nameController.text,
                              _emailController.text,
                              _passwordController.text,
                            )
                          : await repository.loginUser(
                              _emailController.text,
                              _passwordController.text,
                            );
                      EasyLoading.dismiss();
                      if (response.isEmpty) {
                        User.getInstance(
                          name: _nameController.text,
                          email: _emailController.text,
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => HomeScreen(),
                          ),
                        );
                      } else {
                        EasyLoading.showError(response);
                      }
                    }
                  },
                ),
                SizedBox(height: 5),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.grey,
                        ),
                      ),
                      TextSpan(
                        text: isSignUp ? "Log in" : "Sign up",
                        style: const TextStyle(
                          fontSize: 13,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          color: ColorPalette.black,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => toggleView(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
