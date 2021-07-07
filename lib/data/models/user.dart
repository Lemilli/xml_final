import 'package:xml/xml.dart';

User userFromXml(String str) {
  final docXML = XmlDocument.parse(str);
  print(docXML.toXmlString());
  final result = User.fromXML(docXML.findElements('user').first);
  return result;
}

class User {
  final String email;
  final String name;
  final String imageLink;
  final bool isDogWalker;

  User({
    required this.email,
    required this.name,
    required this.imageLink,
    required this.isDogWalker,
  });

  factory User.fromXML(XmlNode xml) {
    print(xml.children[3].text.toLowerCase());
    return User(
      name: xml.children[0].text,
      email: xml.children[1].text,
      imageLink: xml.children[2].text,
      isDogWalker: xml.children[3].text.toLowerCase() == 'true',
    );
  }

  factory User.empty() {
    return User(
      email: '',
      name: '',
      imageLink: '',
      isDogWalker: false,
    );
  }
}
