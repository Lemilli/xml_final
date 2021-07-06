import 'package:xml/xml.dart';

List<Article> articlesFromXml(String str) {
  final docXML = XmlDocument.parse(str);
  List<Article> result = [];
  docXML.findElements('articles').first.children.forEach((element) {
    result.add(Article.fromXML(element));
  });
  return result;
}

class Article {
  final String heading, content, imageLink;
  final int timeToRead;

  Article({
    required this.heading,
    required this.content,
    required this.imageLink,
    required this.timeToRead,
  });

  factory Article.fromXML(XmlNode xml) {
    //print(xml.children.firstWhere((element) => element.text == '').text.toString());
    //print(int.parse(xml.children[4].text));

    return Article(
      heading: xml.children[0].text,
      content: xml.children[1].text,
      imageLink: xml.children[2].text,
      timeToRead: int.parse(xml.children[3].text),
    );
  }
}
