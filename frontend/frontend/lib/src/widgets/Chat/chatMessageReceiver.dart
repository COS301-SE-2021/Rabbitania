import 'package:flutter/material.dart';
import 'package:frontend/src/models/util_model.dart';

//widget for messages being sent by user
class ChatMessageReceiver extends StatefulWidget {
  final textSentValue;

  ChatMessageReceiver({required this.textSentValue});

  @override
  State<StatefulWidget> createState() {
    return _chatMessageReceiverState();
  }
}

class _chatMessageReceiverState extends State<ChatMessageReceiver> {
  final utilModel = UtilModel();
  @override
  Widget build(BuildContext context) => Container(
        child: Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FittedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    //color of recieved message border is grey
                    border: Border.all(
                      color: utilModel.greenColor,
                      width: 2,
                    ),
                  ),
                  //get value sent through in the constructor
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
        ),
      );
}
