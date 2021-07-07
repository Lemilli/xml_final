import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml_final/components/main_button_widget.dart';
import 'package:xml_final/data/models/walker_request.dart';
import 'package:xml_final/data/repository.dart';
import 'package:xml_final/global_variables/global_functions.dart';
import 'package:xml_final/screens/home_screen/screen.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class WalkPlanningScreen extends StatefulWidget {
  final int price;
  final String walkerName;

  const WalkPlanningScreen({
    required this.price,
    required this.walkerName,
  });
  @override
  _WalkPlanningScreenState createState() => _WalkPlanningScreenState();
}

class _WalkPlanningScreenState extends State<WalkPlanningScreen> {
  DateTime? start;
  DateTime? end;
  final _repository = Repository();

  @override
  Widget build(BuildContext context) {
    void _updateState() {
      setState(() {});
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Walk Planning', style: CustomTextTheme.appBarHeading),
            Text(
              'Fill in some details',
              style: CustomTextTheme.appBarSubheading,
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  onConfirm: (date) {
                    start = date;
                    print(start);
                    _updateState();
                  },
                  currentTime: DateTime.now(),
                );
              },
              child: Row(
                children: [
                  Text(
                    start == null
                        ? 'Select starting date and time'
                        : getFormattedDateTime(start!),
                    style: start == null
                        ? CustomTextTheme.textFieldHint
                        : CustomTextTheme.textFieldInput,
                  ),
                  Spacer(),
                  Icon(Icons.calendar_today),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: ColorPalette.grey,
            ),
            SizedBox(height: 22),
            GestureDetector(
              onTap: () {
                DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  onConfirm: (date) {
                    end = date;
                    print(end);
                    _updateState();
                  },
                  currentTime: DateTime.now(),
                );
              },
              child: Row(
                children: [
                  Text(
                    end == null
                        ? 'Ending date and time'
                        : getFormattedDateTime(end!),
                    style: end == null
                        ? CustomTextTheme.textFieldHint
                        : CustomTextTheme.textFieldInput,
                  ),
                  Spacer(),
                  Icon(Icons.calendar_today),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: ColorPalette.grey,
            ),
            SizedBox(height: 25),
            Row(
              children: [
                Text(
                  'Total time ',
                  style: CustomTextTheme.black_bold_17,
                ),
                Spacer(),
                Text(
                  (start != null && end != null)
                      ? end!.difference(start!).inHours.toString() +
                          ' hours' +
                          ' and ' +
                          (end!.difference(start!).inMinutes -
                                  end!.difference(start!).inHours * 60)
                              .toString() +
                          ' minutes'
                      : '0',
                  style: CustomTextTheme.textFieldInput,
                ),
                SizedBox(width: 2),
              ],
            ),
            SizedBox(height: 22),
            Row(
              children: [
                Text(
                  'Price: ',
                  style: CustomTextTheme.black_bold_17,
                ),
                Spacer(),
                Text(
                  (start != null && end != null)
                      ? (end!.difference(start!).inHours * widget.price)
                              .toString() +
                          r'$'
                      : '0',
                  style: CustomTextTheme.textFieldInput,
                ),
                SizedBox(width: 2),
              ],
            ),
            SizedBox(height: 22),
            MainButtonWidget(
              text: 'Pay',
              onTap: () async {
                if (start == null || end == null) {
                  EasyLoading.showError('Select date and time');
                } else if (end!.difference(start!).inHours < 1) {
                  EasyLoading.showError('Select valid time range');
                } else {
                  final totalProfit =
                      end!.difference(start!).inHours * widget.price;

                  final prefs = await SharedPreferences.getInstance();
                  final _email = prefs.getString('email');

                  final _walkerRequest = WalkerRequest(
                    requesterEmail: _email!,
                    walkerName: widget.walkerName,
                    startDatetime: start!,
                    endDatetime: end!,
                    profit: totalProfit,
                  );

                  final response =
                      await _repository.postWalkerRequest(_walkerRequest);

                  if (response.isEmpty) {
                    EasyLoading.showSuccess('Done!');
                    await Future.delayed(Duration(seconds: 3));
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
    );
  }
}
