import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:xml_final/data/models/review_model.dart';
import 'package:xml_final/data/repository.dart';
import 'package:xml_final/theme/color_theme.dart';

class ReviewsTabWidget extends StatefulWidget {
  final String name;

  const ReviewsTabWidget({required this.name});
  @override
  _ReviewsTabWidgetState createState() => _ReviewsTabWidgetState();
}

class _ReviewsTabWidgetState extends State<ReviewsTabWidget> {
  late final Repository _repository;
  late final List<ReviewModel> _reviews;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _repository = Repository();
    EasyLoading.show(status: 'loading...');
    _reviews = await _repository.getReviews(widget.name);
    print(_reviews);
    EasyLoading.dismiss();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 200.0,
        child: ListView.builder(itemBuilder: (_, index) {
          return Expanded(
            child: SizedBox(
              height: 200,
              child: Column(
                children: [
                  Text(
                    _reviews[index].revieweeName,
                  ),
                  Row(
                    children: List<Widget>.generate(
                      _reviews[index].rating,
                      (i) => Icon(
                        Icons.star,
                        color: ColorPalette.orange,
                      ),
                    ),
                  ),
                  Text(
                    _reviews[index].reviewDescription,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
