import 'package:flutter/material.dart';

import '../Components/message_stream.dart';
import './welcome_screen.dart';
import '../constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chatscreen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textFieldController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  String textMessage;

  @override
  void initState() {
    getloggedInUser();
    super.initState();
  }

  void getloggedInUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print('ERROR MESSAGE : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Hero(
              tag: 'logo',
              child: Container(
                width: 30.0,
                height: 30.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            Text('Chat'),
          ],
        ),
        backgroundColor: Colors.lightBlue,
      ),
      drawer: Drawer(
        child: Expanded(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ListTile(
                  leading: Text('🚧'),
                  title: Text('underconstruction'),
                ),
                ListTile(
                  leading: Text('🚧'),
                  title: Text('underconstruction'),
                ),
                ListTile(
                  leading: Text('🚧'),
                  title: Text('underconstruction'),
                ),
                ListTile(
                  onTap: () {
                    _auth.signOut();
                    Navigator.popUntil(
                        context, ModalRoute.withName(WelcomeScreen.id));
                  },
                  leading: Icon(
                    Icons.exit_to_app,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
            color: Color(0xff0b132b),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessageStream(firestore: _firestore),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textFieldController,
                      onChanged: (value) {
                        textMessage = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        size: 35.0,
                        color: Colors.lightBlueAccent,
                      ),
                      onPressed: () {
                        textFieldController.clear();
                        _firestore.collection('User').add({
                          'Sender': loggedInUser.email,
                          'message': textMessage,
                          'Time': DateTime.now(),
                        });
                      },

                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
