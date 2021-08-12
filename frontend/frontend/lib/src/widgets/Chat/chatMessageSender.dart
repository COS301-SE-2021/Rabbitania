import 'package:flutter/material.dart';
import 'package:frontend/src/models/util_model.dart';

//widget for messages being sent by user
class ChatMessageSender extends StatefulWidget {
  final textSentValue;

  ChatMessageSender({required this.textSentValue});

  @override
  State<StatefulWidget> createState() {
    return _chatMessageSenderState();
  }
}

class _chatMessageSenderState extends State<ChatMessageSender> {
  UtilModel utilModel = UtilModel();
  @override
  Widget build(BuildContext context) => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  //color of recieved message border is grey
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                //get value sent through in the constructor
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    widget.textSentValue,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
