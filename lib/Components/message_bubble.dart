import 'package:flutter/material.dart';

class TextBubble extends StatelessWidget {
  TextBubble({
    @required this.sender,
    @required this.text,
    @required this.isMe,
    @required this.time,
  });

  final String sender;
  final text;
  final bool isMe;
  final time;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender.split('@')[0],
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          Material(
            color: isMe ? Colors.lightBlue : Color(0xff121c3b),
            elevation: 5.0,
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                  )
                : BorderRadius.only(
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                  ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: text,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    // TextSpan(
                    //   text: '  $time',
                    //   style: TextStyle(
                    //     fontSize: 10.0,
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
