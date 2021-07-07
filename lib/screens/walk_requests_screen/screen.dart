import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:xml_final/data/models/walker_request.dart';
import 'package:xml_final/data/repository.dart';
import 'package:xml_final/global_variables/global_functions.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class WalkRequestsScreen extends StatefulWidget {
  final String walkerName;

  const WalkRequestsScreen({required this.walkerName});
  @override
  _WalkRequestsScreenState createState() => _WalkRequestsScreenState();
}

class _WalkRequestsScreenState extends State<WalkRequestsScreen> {
  late final Repository _repository;
  late final List<WalkerRequest> _walkerRequests;
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _repository = Repository();
    _walkerRequests = await _repository.getWalkerRequests(widget.walkerName);
    if (_walkerRequests.isEmpty) {
      setState(() {
        EasyLoading.showError(
          'Error occured. Try later',
          duration: Duration(seconds: 3),
        );
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Walk Requests',
                      style: CustomTextTheme.appBarHeading,
                    ),
                    Text(
                      'See your requested walks',
                      style: CustomTextTheme.appBarSubheading,
                    ),
                    SizedBox(height: 22),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _walkerRequests.length,
                        itemBuilder: (_, index) => Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorPalette.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          margin: EdgeInsets.only(bottom: 22),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 16),
                          clipBehavior: Clip.none,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Request from: ',
                                        style:
                                            CustomTextTheme.walk_request_grey,
                                      ),
                                      Text(
                                        _walkerRequests[index].requesterEmail,
                                        style:
                                            CustomTextTheme.walk_request_black,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Profit: ',
                                        style:
                                            CustomTextTheme.walk_request_grey,
                                      ),
                                      Text(
                                        _walkerRequests[index]
                                                .profit
                                                .toString() +
                                            r'$',
                                        style:
                                            CustomTextTheme.walk_request_black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'From: ',
                                        style:
                                            CustomTextTheme.walk_request_grey,
                                      ),
                                      Text(
                                        getFormattedDateTime(
                                            _walkerRequests[index]
                                                .startDatetime),
                                        style:
                                            CustomTextTheme.walk_request_black,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Until: ',
                                        style:
                                            CustomTextTheme.walk_request_grey,
                                      ),
                                      Text(
                                        getFormattedDateTime(
                                            _walkerRequests[index].endDatetime),
                                        style:
                                            CustomTextTheme.walk_request_black,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
