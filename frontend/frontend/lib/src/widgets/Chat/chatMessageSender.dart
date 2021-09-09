import 'package:flutter/material.dart';
import 'package:frontend/src/models/util_model.dart';

//widget for messages being sent by user
class ChatMessageSender extends StatefulWidget {
  final textSentValue;
  var uid;
  var timestamp;
  ChatMessageSender(
      {required this.textSentValue, this.uid, required this.timestamp});

  @override
  State<StatefulWidget> createState() {
    return _chatMessageSenderState();
  }
}

class _chatMessageSenderState extends State<ChatMessageSender> {
  UtilModel utilModel = UtilModel();
  @override
  Widget build(BuildContext context) => Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.1),
                  //width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0),
                      bottomLeft: const Radius.circular(25.0),
                    ),
                    //color of recieved message border is grey
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  //get value sent through in the constructor
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          widget.textSentValue,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        alignment: Alignment.centerRight,
                        widthFactor: 0.5,
                        child: Text(
                          widget.timestamp,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
