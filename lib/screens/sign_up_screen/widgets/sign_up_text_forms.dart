import 'package:flutter/material.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class SignUpTextForms extends StatefulWidget {
  final bool isSignUp;
  final GlobalKey<FormState> formKey;

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  SignUpTextForms({
    required this.isSignUp,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  SignUpTextFormsState createState() => SignUpTextFormsState();
}

class SignUpTextFormsState extends State<SignUpTextForms> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SizedBox(height: widget.isSignUp ? 22 : 0),
          widget.isSignUp
              ? TextFormField(
                  controller: widget.nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please, enter some text';
                    } else {
                      final isValid = RegExp(
                              r"^([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)")
                          .hasMatch(value);
                      if (isValid) {
                        return null;
                      } else {
                        return 'Error, enter valid name';
                      }
                    }
                  },
                  keyboardType: TextInputType.name,
                  maxLength: 30,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    hintStyle: CustomTextTheme.textFieldHint,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorPalette.orange),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorPalette.textFieldHint),
                    ),
                  ),
                )
              : SizedBox(),
          SizedBox(height: 22),
          TextFormField(
            controller: widget.emailController,
            maxLength: 20,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please, enter some text';
              } else {
                bool isValid = RegExp(
                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                    .hasMatch(value);
                if (isValid) {
                  return null;
                } else {
                  return 'Enter valid email';
                }
              }
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "E-mail",
              hintStyle: CustomTextTheme.textFieldHint,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorPalette.orange),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorPalette.textFieldHint),
              ),
            ),
          ),
          SizedBox(height: 22),
          TextFormField(
            controller: widget.passwordController,
            maxLength: 20,
            obscureText: _obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please, enter some text';
              } else {
                bool hasUppercase = value.contains(RegExp(r'[A-Z]'));
                bool hasDigits = value.contains(RegExp(r'[0-9]'));
                bool hasLowercase = value.contains(RegExp(r'[a-z]'));
                bool hasMinLength = value.length >= 6;
                if (!hasUppercase) {
                  return 'Enter at least 1 uppercase character';
                } else if (!hasDigits) {
                  return 'Enter at least 1 digit';
                } else if (!hasLowercase) {
                  return 'Enter at least 1 lowercase character';
                } else if (!hasMinLength) {
                  return 'Enter at least 6 characters';
                } else {
                  return null;
                }
              }
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                splashRadius: 15,
                icon: _obscureText
                    ? Icon(
                        Icons.visibility,
                        color: ColorPalette.textFieldHint,
                      )
                    : Icon(
                        Icons.visibility_off,
                        color: ColorPalette.textFieldHint,
                      ),
                onPressed: () {
                  _toggleVisibility();
                },
              ),
              hintText: "Password",
              hintStyle: CustomTextTheme.textFieldHint,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorPalette.orange),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: ColorPalette.textFieldHint),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
