import 'package:xml/xml.dart';

List<Message> messagesFromXml(String str) {
  final docXML = XmlDocument.parse(str);
  List<Message> result = [];
  docXML.findElements('messages').first.children.forEach((element) {
    result.add(Message.fromXML(element));
  });
  return result;
}

class Message {
  String text, sender, receiver, datetime;

  Message(
      {required this.text,
      required this.sender,
      required this.receiver,
      required this.datetime});

  void printData() {
    print(text);
    print(sender);
    print(receiver);
  }

  factory Message.fromXML(XmlNode xml) {
    return Message(
      text: xml.children[0].text,
      sender: xml.children[1].text,
      receiver: xml.children[2].text,
      datetime: xml.children[3].text,
    );
  }
}
