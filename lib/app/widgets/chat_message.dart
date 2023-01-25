import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
      {super.key,
        required this.text,
        required this.sender,});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Bubble(
      margin: const BubbleEdges.only(top: 5, bottom: 5),
      alignment: sender == "user" ?Alignment.topRight : Alignment.topLeft,
      nip: sender == "user" ? BubbleNip.rightTop : BubbleNip.leftTop,
      color: sender == "user" ? const Color.fromRGBO(225, 255, 199, 1.0): Colors.white,
      child:  Text(text, textAlign: sender == "user" ? TextAlign.right : TextAlign.left),
    );
  }
}
