import 'package:flutter/material.dart';
import 'package:scholar_chat/modals/message.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.message}) : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(8),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            )),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({Key? key, required this.message})
      : super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(8),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
        decoration: const BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            )),
      ),
    );
  }
}
