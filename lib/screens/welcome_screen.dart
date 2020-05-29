import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:airochat/Components/round_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcomescreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    controller.forward();
    // controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });
    animation = CurvedAnimation(curve: Curves.decelerate, parent: controller);
    controller.addListener(() {
      setState(() {});
      //  print(controller.status);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0b132b).withOpacity(controller.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset('images/logo.png'),
                  ),
                  height: 60,
                ),
                TypewriterAnimatedTextKit(
                  pause: Duration(milliseconds: 1000),
                  speed: Duration(milliseconds: 500),
                  totalRepeatCount: 1000,
                  text: [
                    'Airo Chat',
                  ],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundButton(
              color: Colors.lightBlue,
              text: 'Log In',
              // textSize: controller.value * 16,
              onPressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundButton(
              color: Colors.blueAccent,
              text: 'Register',
              onPressed: () {
                //Go to registration screen.
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
