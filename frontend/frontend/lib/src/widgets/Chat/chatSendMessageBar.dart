import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/helper/Chat/SignalRHelper.dart';
import 'package:frontend/src/models/util_model.dart';

class ChatSendMessageBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _chatSendMessageBarState();
  }
}

class _chatSendMessageBarState extends State<ChatSendMessageBar> {
  final messageController = TextEditingController();
  final utilModel = UtilModel();
  final signalRHelper = SignalRHelper();
  @override
  Widget build(BuildContext context) => Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: TextField(
              controller: messageController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              cursorColor: utilModel.greenColor,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: utilModel.greenColor, width: 2.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                fillColor: Colors.transparent,
                focusColor: utilModel.greenColor,
                hoverColor: utilModel.greenColor,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: FloatingActionButton(
                backgroundColor: utilModel.greenColor,
                child: Icon(
                  FontAwesomeIcons.paperPlane,
                  color: Colors.black,
                ),
                onPressed: () {
                  signalRHelper.sendMessage(
                      FirebaseAuth.instance.currentUser!.displayName,
                      messageController.text);
                }),
          ),
        ],
      );
}
