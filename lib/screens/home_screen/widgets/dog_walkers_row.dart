import 'package:flutter/material.dart';
import 'package:xml_final/data/models/dog_walker.dart';
import 'package:xml_final/screens/dog_walker_profile_screen/screen.dart';
import 'package:xml_final/theme/color_theme.dart';
import 'package:xml_final/theme/custom_text_theme.dart';

class DogWalkersRow extends StatefulWidget {
  final bool isSuggested;
  final List<DogWalker> dogWalkers;

  const DogWalkersRow({
    required this.isSuggested,
    required this.dogWalkers,
  });

  @override
  _DogWalkersRowState createState() => _DogWalkersRowState();
}

class _DogWalkersRowState extends State<DogWalkersRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      child: ListView.builder(
        reverse: widget.isSuggested ? true : false,
        scrollDirection: Axis.horizontal,
        itemCount: widget.dogWalkers.length,
        shrinkWrap: true,
        itemBuilder: (_, index) => GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DogWalkerProfileScreen(
                dogWalker: widget.dogWalkers[index],
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: 40),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Image.network(
                  widget.dogWalkers.elementAt(index).imageLink,
                  width: 200,
                  height: 125,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 200,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.dogWalkers.elementAt(index).name,
                          style: CustomTextTheme.textFieldInput,
                        ),
                        SizedBox(height: 5),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 15,
                                color: ColorPalette.yellow,
                              ),
                              Text(
                                widget.dogWalkers
                                    .elementAt(index)
                                    .rating
                                    .toString(),
                                style: CustomTextTheme.rating,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: ColorPalette.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            r'$' +
                                widget.dogWalkers
                                    .elementAt(index)
                                    .price
                                    .toString() +
                                '/h',
                            style: CustomTextTheme.price,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
