import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:xml/xml.dart';
import 'package:xml_final/data/models/message.dart';

class SocketChat {
  late Socket socket;

  Future<void> initSocket() async {
    final url = kIsWeb ? 'localhost' : '10.0.2.2';
    socket = await Socket.connect(url, 4567);
    print('Connected to: ${socket.remoteAddress.address}:${socket.remotePort}');

    // listen for responses from the server
    socket.listen(
      (Uint8List data) {
        final serverResponse = String.fromCharCodes(data).trim();
        print('Server: $serverResponse');

        final docXML = XmlDocument.parse(serverResponse);
        final message = Message.fromXML(docXML.findElements('message').first);
      },
      onError: (error) {
        print(error);
        socket.destroy();
      },
      onDone: () {
        print('Server left.');
        socket.destroy();
      },
    );
  }

  Future<void> sendMessage(String message) async {
    print('Client: $message');
    socket.write(message);
  }

  void closeConnection() {
    socket.destroy();
  }
}
