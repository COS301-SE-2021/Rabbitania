import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/models/util_model.dart';

//widget for messages being sent by user
class ChatMessageReceiver extends StatefulWidget {
  final textSentValue;
  var uid;
  var timestamp;
  ChatMessageReceiver(
      {required this.textSentValue, this.uid, required this.timestamp});

  @override
  State<StatefulWidget> createState() {
    return _chatMessageReceiverState();
  }
}

class _chatMessageReceiverState extends State<ChatMessageReceiver> {
  final utilModel = UtilModel();
  final firestoreHelper = FireStoreHelper();
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
                      topRight: const Radius.circular(25.0),
                      bottomRight: const Radius.circular(25.0),
                      topLeft: const Radius.circular(25.0),
                    ),
                    //color of recieved message border is grey
                    border: Border.all(
                      color: utilModel.greenColor,
                      width: 2,
                    ),
                  ),
                  //get value sent through in the constructor
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: widget.uid != null,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                          child: StreamBuilder(
                            stream: firestoreHelper.getUserById(widget.uid),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data.docs[0]['displayName'],
                                  style: TextStyle(color: utilModel.greenColor),
                                );
                              }
                              return Align();
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          widget.textSentValue,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.5,
                        child: Text(
                          widget.timestamp,
                          textAlign: TextAlign.start,
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
