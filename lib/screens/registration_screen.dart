import 'package:airochat/constants.dart';
import 'package:airochat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:airochat/Components/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registerscreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
// String username ;
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
                  padding: EdgeInsets.all(48.0),
                  child: Container(
                    height: 150.0,
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  email = '$value@email.com';
                },
                textAlign: TextAlign.start,
                keyboardType: TextInputType.emailAddress,
                decoration: kRegisterTextFieldDecoration.copyWith(
                  labelText: 'Create username',
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextField(
                onChanged: (value) {
                  password = value;

                  //Do something with the user input.
                },
                obscureText: true,
                textAlign: TextAlign.start,
                decoration: kRegisterTextFieldDecoration.copyWith(
                  labelText: 'Create password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundButton(
                  color: Colors.blueAccent,
                  text: 'Register',
                  onPressed: () async {
                    if (email != null && password != null) {
                      setState(() {
                        showProgressIndicator = true;
                      });
                    }
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);

                      if (newUser != null) {
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            ChatScreen.id,
                            ModalRoute.withName(WelcomeScreen.id));
                      }
                    } catch (e) {
                      print('Error Message => ' + e.toString());
                    }
                    setState(() {
                      showProgressIndicator = false;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
