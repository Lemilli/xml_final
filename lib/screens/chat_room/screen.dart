import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml_final/data/models/message.dart';
import 'package:xml_final/data/repository.dart';
import 'package:xml_final/data/socket_chat.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:xml_final/screens/chat_room/widgets/message_buble.dart';

class ChatRoomScreen extends StatefulWidget {
  final String receiver;

  const ChatRoomScreen({required this.receiver});

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final channel = WebSocketChannel.connect(
    Uri.parse(kIsWeb ? 'ws://localhost:4567' : 'ws://10.0.2.2:4567'),
  );
  bool isLoading = true;
  bool isError = false;
  late final String _myEmail;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final prefs = await SharedPreferences.getInstance();
    _myEmail = prefs.getString('email')!;
    // final socket = SocketChat();
    // await socket.initSocket();
    // socket.sendMessage('Message');
    // if (_dogWalkers.isEmpty) {
    //   setState(() {
    //     isError = true;
    //   });
    // }
    // setState(() {
    //   isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final messages = messagesFromXml(snapshot.data.toString());
              return Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (_, index) {
                    return MessageBubble(
                      text: messages[index].text,
                      email: messages[index].sender,
                      isMyMessage: messages[index].sender == _myEmail,
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Text("Error");
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    channel.sink.close();
  }
}
