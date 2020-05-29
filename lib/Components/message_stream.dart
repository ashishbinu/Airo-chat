import 'package:airochat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:airochat/Components/message_bubble.dart';

class MessageStream extends StatelessWidget {
  MessageStream({
    @required this.firestore,
  });

  final Firestore firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('User').orderBy('Time').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        var messages = snapshot.data.documents.reversed;
        List<Widget> textWidgets = [];

        for (var message in messages) {
          final text = message.data['message'];
          final String sender = message.data['Sender'];
          final time = message.data['Time'];
          final currentUser = loggedInUser.email;
          bool isMe = (sender == currentUser);
          textWidgets.add(
            TextBubble(
              sender: sender,
              text: text,
              isMe: isMe,
              time: time,
            ),
          );
        }

        return Expanded(
          child: ListView(
            reverse: true,
            children: textWidgets,
          ),
        );
      },
    );
  }
}
