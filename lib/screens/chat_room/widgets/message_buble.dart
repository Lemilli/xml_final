import 'package:flutter/material.dart';
import 'package:xml_final/theme/color_theme.dart';

class MessageBubble extends StatelessWidget {
  final String text;
  final String email;
  final bool isMyMessage;

  const MessageBubble({
    required this.text,
    required this.email,
    required this.isMyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Text(
              email,
              style: TextStyle(fontSize: 12.0, color: Colors.black54),
            ),
          ),
          Material(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
              topLeft: isMyMessage ? Radius.circular(30.0) : Radius.zero,
              topRight: !isMyMessage ? Radius.circular(30.0) : Radius.zero,
            ),
            elevation: 5.0,
            color: isMyMessage ? ColorPalette.orangeBubble : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMyMessage ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
