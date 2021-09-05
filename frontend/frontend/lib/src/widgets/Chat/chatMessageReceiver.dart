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
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.1),
                  //width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.only(
                      topRight: const Radius.circular(40.0),
                      bottomRight: const Radius.circular(40.0),
                      topLeft: const Radius.circular(40.0),
                    ),
                    //color of recieved message border is grey
                    border: Border.all(
                      color: utilModel.greenColor,
                      width: 2,
                    ),
                  ),
                  //get value sent through in the constructor
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
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
