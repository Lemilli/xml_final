import 'package:xml/xml.dart';

User userFromXml(String str) {
  final docXML = XmlDocument.parse(str);
  final result = User.fromXML(docXML.findElements('user').first);
  return result;
}

class User {
  final String email;
  final String name;
  final String imageLink;

  User({
    required this.email,
    required this.name,
    required this.imageLink,
  });

  factory User.fromXML(XmlNode xml) {
    return User(
      name: xml.children[0].text,
      email: xml.children[1].text,
      imageLink: xml.children[2].text,
    );
  }

  factory User.empty() {
    return User(
      email: '',
      name: '',
      imageLink: '',
    );
  }
}
