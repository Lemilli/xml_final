import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:xml_final/components/main_button_widget.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class WalkPlanningScreen extends StatefulWidget {
  final int price;

  const WalkPlanningScreen({required this.price});
  @override
  _WalkPlanningScreenState createState() => _WalkPlanningScreenState();
}

class _WalkPlanningScreenState extends State<WalkPlanningScreen> {
  DateTime? start;
  DateTime? end;

  String getFormattedDateTime(DateTime dateTime) {
    final minute = dateTime.minute < 10
        ? '0' + dateTime.minute.toString()
        : dateTime.minute.toString();
    final hour = dateTime.hour < 10
        ? '0' + dateTime.hour.toString()
        : dateTime.hour.toString();
    late final month;
    switch (dateTime.month) {
      case DateTime.january:
        month = 'January';
        break;
      case DateTime.february:
        month = 'February';
        break;
      case DateTime.march:
        month = 'March';
        break;
      case DateTime.april:
        month = 'April';
        break;
      case DateTime.may:
        month = 'May';
        break;
      case DateTime.june:
        month = 'June';
        break;
      case DateTime.july:
        month = 'July';
        break;
      case DateTime.august:
        month = 'August';
        break;
      case DateTime.september:
        month = 'September';
        break;
      case DateTime.october:
        month = 'October';
        break;
      case DateTime.november:
        month = 'November';
        break;
      case DateTime.september:
        month = 'September';
        break;
      case DateTime.december:
        month = 'December';
        break;
    }
    return '${dateTime.day} $month $hour:$minute';
  }

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
              onTap: () {
                //TODO ADD PAYMENT and validation I GUESS
                if (start == null || end == null) {
                  EasyLoading.showError('Select date and time');
                } else if (end!.difference(start!).inHours < 1) {
                  EasyLoading.showError('Select valid time range');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
