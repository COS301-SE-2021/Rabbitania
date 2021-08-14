import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/widgets/Noticeboard/noticeboardCreateCard.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Chat/ChatRoomScreen.dart';

class ChatSendMessageBar extends StatefulWidget {
  final idUser;
  final myId;
  ChatSendMessageBar(this.idUser, this.myId);
  @override
  State<StatefulWidget> createState() {
    return _chatSendMessageBarState();
  }
}

class _chatSendMessageBarState extends State<ChatSendMessageBar> {
  final fireStoreHelper = FireStoreHelper();
  final utilModel = UtilModel();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: TextField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                controller: messageController,
              ),
            ),
            Expanded(
              flex: 2,
              child: FloatingActionButton(
                backgroundColor: utilModel.greenColor,
                child: Icon(FontAwesomeIcons.paperPlane,
                    color: utilModel.greyColor),
                onPressed: () {
                  if (messageController.text != '') {
                    fireStoreHelper.sendMessage(
                        widget.idUser, widget.myId, messageController.text);
                  }
                },
              ),
            ),
          ],
        ),
      );
}
