// import 'dart:js';

import 'package:chat_app/components/text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/db/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChatPage extends StatelessWidget {
  final String receivedEmail;
  final String receivedID;
  ChatPage({super.key, required this.receivedEmail, required this.receivedID});

  final TextEditingController textMessageController = TextEditingController();

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  void sendMessage() async {
    if (textMessageController.text.isNotEmpty) {
      await chatService.sendMessage(receivedID, textMessageController.text);
      textMessageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receivedEmail),
      ),
      body: Column(
        children: [
          Expanded(child: buildMessageList()),
          buildUserInput(),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    String senderID = authService.getCurrentUser()!.uid;
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("ERROR");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading . . . ");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((docs) => buildMessageItem(docs))
              .toList(),
        );
      },
      stream: chatService.getMessage(receivedID, senderID),
    );
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> map = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = map['senderID'] == authService.getCurrentUser()!.uid;

    var aligment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: aligment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(map['message']),
        ],
      ),
    );
  }

  Widget buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: TextFieldPrimary(
                hint: "Type a message...",
                secured: false,
                controller: textMessageController),
          ),

          //button
          Container(
            margin: EdgeInsets.only(right: 25),
            decoration: const BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
