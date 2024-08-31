import 'package:flutter/material.dart';
import '../widgets/chat_interface_widget.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Doctor'),
      ),
      body: ChatInterfaceWidget(),
    );
  }
}
