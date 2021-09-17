import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/models/utilModel.dart';

class ChatSendMessageBar extends StatefulWidget {
  final idUser;
  final myId;
  ChatSendMessageBar(this.idUser, this.myId);
  @override
  State<StatefulWidget> createState() {
    return ChatSendMessageBarState();
  }
}

class ChatSendMessageBarState extends State<ChatSendMessageBar> {
  final fireStoreHelper = FireStoreHelper();
  final utilModel = UtilModel();
  final messageController = TextEditingController();
  var icon = FontAwesomeIcons.paperPlane;
  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: TextField(
                minLines: 1,
                maxLines: 10,
                cursorColor: utilModel.greenColor,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: utilModel.greenColor,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: utilModel.greenColor,
                      width: 1,
                    ),
                  ),
                ),
                controller: messageController,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02),
                width: MediaQuery.of(context).size.width * 0.05,
                height: MediaQuery.of(context).size.height * 0.05,
                child: FloatingActionButton(
                  backgroundColor: utilModel.greenColor,
                  child: Icon(this.icon, color: utilModel.greyColor, size: 20),
                  onPressed: () {
                    if (messageController.text != '') {
                      fireStoreHelper.sendMessage(
                          widget.idUser, widget.myId, messageController.text);
                    }
                    messageController.text = '';
                  },
                ),
              ),
            ),
          ],
        ),
      );
}
