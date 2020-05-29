import 'package:airochat/constants.dart';
import 'package:airochat/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:airochat/Components/round_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginscreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showProgressIndicator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: ModalProgressHUD(
        color: Colors.black,
        opacity: 0.5,
        inAsyncCall: showProgressIndicator,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Container(
                    height: 150.0,
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
              ),
              TextField(
                onChanged: (value) {
                  email = '$value@email.com';
                },
                textAlign: TextAlign.left,
                keyboardType: TextInputType.emailAddress,
                decoration: kLoginTextFieldDecoration.copyWith(
                  labelText: 'Username',
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                textAlign: TextAlign.left,
                obscureText: true,
                decoration: kLoginTextFieldDecoration.copyWith(
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundButton(
                color: Colors.lightBlue,
                text: 'Log In',
                onPressed: () async {
                  if (email != null && password != null) {
                    setState(() {
                      showProgressIndicator = true;
                    });
                  }
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);

                    if (user != null) {
                      Navigator.pushNamedAndRemoveUntil(context, ChatScreen.id,
                          ModalRoute.withName(WelcomeScreen.id));
                    }
                  } catch (e) {
                    print('Error Message : ' + e.toString());
                  }
                  setState(
                    () {
                      showProgressIndicator = false;
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
