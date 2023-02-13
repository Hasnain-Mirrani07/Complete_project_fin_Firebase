
import 'package:flutter/material.dart';
class ChatGptScreen extends StatefulWidget {
  const ChatGptScreen({super.key});

  @override
  State<ChatGptScreen> createState() => _ChatGptScreenState();
}

class _ChatGptScreenState extends State<ChatGptScreen> {
//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
final openAI = OpenAI.instance.build(token: token,baseOption: HttpSetup(receiveTimeout: 6000),isLogger: true);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}