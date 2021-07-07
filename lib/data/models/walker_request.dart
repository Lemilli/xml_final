import 'package:xml/xml.dart';

List<WalkerRequest> walkerRequestsXml(String str) {
  final docXML = XmlDocument.parse(str);
  print(docXML.toXmlString());

  List<WalkerRequest> result = [];
  docXML.findElements('walker_requests').first.children.forEach((element) {
    result.add(WalkerRequest.fromXML(element));
  });
  return result;
}

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
    return WalkerRequest(
      requesterEmail: xml.children[0].text,
      walkerName: xml.children[1].text,
      startDatetime: DateTime.parse(xml.children[2].text),
      endDatetime: DateTime.parse(xml.children[3].text),
      profit: int.parse(xml.children[4].text),
    );
  }
}
