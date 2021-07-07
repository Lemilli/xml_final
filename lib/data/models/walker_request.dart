import 'package:xml/xml.dart';

class WalkerRequest {
  final String requesterEmail, walkerName;
  final DateTime startDatetime, endDatetime;
  final int profit;

  WalkerRequest({
    required this.requesterEmail,
    required this.walkerName,
    required this.startDatetime,
    required this.endDatetime,
    required this.profit,
  });

  factory WalkerRequest.fromXML(XmlNode xml) {
    print(DateTime.parse(xml.children[2].text));
    print(DateTime.parse(xml.children[3].text));
    return WalkerRequest(
      requesterEmail: xml.children[0].text,
      walkerName: xml.children[1].text,
      startDatetime: DateTime.parse(xml.children[2].text),
      endDatetime: DateTime.parse(xml.children[3].text),
      profit: int.parse(xml.children[4].text),
    );
  }
}
