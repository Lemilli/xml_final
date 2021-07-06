import 'package:xml/xml.dart';

List<ReviewModel> reviewsFromXml(String str) {
  final docXML = XmlDocument.parse(str);
  List<ReviewModel> result = [];
  docXML.findElements('reviews').first.children.forEach((element) {
    result.add(ReviewModel.fromXML(element));
  });
  return result;
}

class ReviewModel {
  String walkerName;
  String revieweeName;
  int rating;
  String reviewDescription;

  ReviewModel({
    required this.walkerName,
    required this.revieweeName,
    required this.rating,
    required this.reviewDescription,
  });

  factory ReviewModel.fromXML(XmlNode xml) {
    return ReviewModel(
      walkerName: xml.children[0].text,
      revieweeName: xml.children[1].text,
      rating: int.parse(xml.children[2].text),
      reviewDescription: xml.children[3].text,
    );
  }
}
