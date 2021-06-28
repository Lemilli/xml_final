import 'package:xml/xml.dart';

List<DogWalker> dogWalkersFromXml(String str) {
  final docXML = XmlDocument.parse(str);
  List<DogWalker> result = [];
  docXML.findElements('dog_walkers').first.children.forEach((element) {
    result.add(DogWalker.fromXML(element));
  });
  return result;
}

class DogWalker {
  DogWalker({
    required this.name,
    required this.rating,
    required this.price,
    required this.age,
    required this.experience,
    required this.description,
    required this.imageLink,
    required this.walksCount,
  });

  String name, description, imageLink;
  double rating;
  int price, age, experience, walksCount;

  factory DogWalker.fromXML(XmlNode xml) {
    //print(xml.children.firstWhere((element) => element.text == '').text.toString());
    //print(int.parse(xml.children[4].text));

    return DogWalker(
      name: xml.children[0].text,
      rating: double.parse(xml.children[1].text),
      price: int.parse(xml.children[2].text),
      age: int.parse(xml.children[3].text),
      experience: int.parse(xml.children[4].text),
      description: xml.children[5].text,
      imageLink: xml.children[6].text,
      walksCount: int.parse(xml.children[7].text),
    );
  }
}
