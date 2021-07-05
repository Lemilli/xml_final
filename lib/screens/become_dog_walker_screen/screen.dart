import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:xml_final/components/main_button_widget.dart';
import 'package:xml_final/data/models/dog_walker.dart';
import 'package:xml_final/data/repository.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class BecomeDogWalkerScreen extends StatefulWidget {
  final String username;

  const BecomeDogWalkerScreen({required this.username});

  @override
  _BecomeDogWalkerScreenState createState() => _BecomeDogWalkerScreenState();
}

class _BecomeDogWalkerScreenState extends State<BecomeDogWalkerScreen> {
  final repository = Repository();

  final formKey = GlobalKey<FormState>();
  bool isSignUp = true;

  final _ageController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Become Dog Walker', style: CustomTextTheme.appBarHeading),
              Text(
                'Fill in some details',
                style: CustomTextTheme.appBarSubheading,
              ),
              SizedBox(height: 30),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _ageController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please, enter some number';
                        } else {
                          final age = int.parse(value);
                          if (age < 16)
                            return 'You must be at least 16 years old';
                          else if (age > 200)
                            return 'Make sure age is valid';
                          else
                            return null;
                        }
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      keyboardType: TextInputType.number,
                      maxLength: 3,
                      decoration: InputDecoration(
                        hintText: "Age",
                        hintStyle: CustomTextTheme.textFieldHint,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorPalette.orange),
                        ),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorPalette.textFieldHint),
                        ),
                      ),
                    ),
                    SizedBox(height: 22),
                    TextFormField(
                      controller: _priceController,
                      maxLength: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please, enter some number';
                        } else if (int.parse(value) < 0)
                          return 'Input positive numbers only';
                        else
                          return null;
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Price per hour (in dollars)",
                        hintStyle: CustomTextTheme.textFieldHint,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorPalette.orange),
                        ),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorPalette.textFieldHint),
                        ),
                      ),
                    ),
                    SizedBox(height: 22),
                    TextFormField(
                      controller: _descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please, enter some description';
                        } else
                          return null;
                      },
                      maxLength: 150,
                      decoration: InputDecoration(
                        hintText: "Brief information about you",
                        hintStyle: CustomTextTheme.textFieldHint,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorPalette.orange),
                        ),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorPalette.textFieldHint),
                        ),
                      ),
                    ),
                    SizedBox(height: 22),
                    TextFormField(
                      controller: _imageLinkController,
                      maxLength: 200,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please, enter the link';
                        } else {
                          final isValid = RegExp(
                                  r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)")
                              .hasMatch(value);
                          if (isValid)
                            return null;
                          else
                            return 'Link should start with http or https';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Link to your photo",
                        hintStyle: CustomTextTheme.textFieldHint,
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: ColorPalette.orange),
                        ),
                        border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorPalette.textFieldHint),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22),
              MainButtonWidget(
                text: 'Send request',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    EasyLoading.show(status: 'loading...');

                    final dogWalker = DogWalker(
                      name: widget.username,
                      rating: 5,
                      price: int.parse(_priceController.text),
                      age: int.parse(_ageController.text),
                      experience: 0,
                      description: _descriptionController.text,
                      imageLink: _imageLinkController.text,
                      walksCount: 0,
                    );
                    final response = await repository.postDogWalker(dogWalker);
                    EasyLoading.dismiss();

                    if (response.isEmpty) {
                      EasyLoading.showSuccess('Success!');
                      await Future.delayed(Duration(seconds: 2));
                      EasyLoading.dismiss();

                      Navigator.of(context).pop();
                    } else {
                      EasyLoading.showError(response);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
