import 'package:flutter/material.dart';
import 'package:xml_final/data/models/review_model.dart';
import 'package:xml_final/data/repository.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

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
    _reviews = await _repository.getReviews(widget.name);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : _reviews.isEmpty
            ? Center(
                child: Text(
                  'No reviews yet :(',
                  style: CustomTextTheme.profile_details_black,
                ),
              )
            : SizedBox(
                height: 200.0,
                child: ListView.builder(
                  itemCount: _reviews.length,
                  itemBuilder: (_, index) {
                    return SizedBox(
                      height: 60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _reviews[index].revieweeName,
                                style: CustomTextTheme.profile_details_black,
                              ),
                              Text(
                                _reviews[index].reviewDescription,
                                style: CustomTextTheme.profile_details_grey,
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            children: List<Icon>.generate(
                              _reviews[index].rating,
                              (i) => Icon(
                                Icons.star,
                                color: ColorPalette.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
  }
}
