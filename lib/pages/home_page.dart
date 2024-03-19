import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/drawer.dart';
import 'package:chat_app/services/db/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService chatService = ChatService();
  final AuthService authService = AuthService();

  logout() {
    final _authService = AuthService();
    _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homee"),
        centerTitle: true,
      ),
      drawer: DrawerMain(),
      body: userChatList(),
    );
  }

  Widget userChatList() {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("ERROR");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading....");
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => userChatListItem(userData, context))
              .toList(),
        );
      },
      stream: chatService.getUserStream(),
    );
  }

  Widget userChatListItem(Map<String, dynamic> userData, BuildContext context) {
    if (userData['email'] != authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                    receivedEmail: userData['email'],
                    receivedID: userData['uid']),
              ));
        },
      );
    } else {
      return Container();
    }
  }
}
