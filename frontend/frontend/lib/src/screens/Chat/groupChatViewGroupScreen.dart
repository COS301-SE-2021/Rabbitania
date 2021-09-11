import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/helper/Chat/groupChatHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Chat/ChatViewUsersScreen.dart';
import 'package:frontend/src/screens/Chat/groupChatAddParticipantScreen.dart';
import 'package:frontend/src/widgets/Chat/chatUsersCard.dart';

class GroupChatViewGroupScreen extends StatefulWidget {
  final roomName;
  GroupChatViewGroupScreen({required this.roomName});
  @override
  GroupChatViewGroupScreenState createState() =>
      GroupChatViewGroupScreenState();
}

class GroupChatViewGroupScreenState extends State<GroupChatViewGroupScreen> {
  final firestoreHelper = FireStoreHelper();
  final utilModel = UtilModel();
  bool visibility = false;
  decodeBase64(String base64Image) {
    return Image.memory(
      Base64Decoder().convert(base64Image),
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestoreHelper.getGroupRoomByRoomName(widget.roomName),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot1) {
        if (snapshot1.hasData) {
          List<Widget> children = [];
          var participants = snapshot1.data.docs[0]['participants'];
          var avatar = snapshot1.data.docs[0]['avatar'];
          for (int i = 0; i < participants.length; i++) {
            children.add(
              StreamBuilder(
                stream: firestoreHelper.getUserById(participants[i]),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
                  if (snapshot2.hasData) {
                    var uid = snapshot2.data.docs[0]['uid'];
                    var displayName = snapshot2.data.docs[0]['displayName'];
                    var displayImage = snapshot2.data.docs[0]['avatar'];
                    return ChatUsersCard(
                        groupChatHelper: GroupChatHelper(),
                        idUser: uid,
                        displayImage: displayImage,
                        displayName: displayName);
                  }
                  return CircularProgressIndicator(color: utilModel.greenColor);
                },
              ),
            );
          }
          return Scaffold(
            backgroundColor: utilModel.greyColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: SizedBox(
                      height: 60.0,
                      width: 60.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(72),
                        child: decodeBase64(avatar),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: InkWell(
                      child: Text(
                        widget.roomName,
                        style: TextStyle(
                            color: utilModel.greenColor, fontSize: 35),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.plus),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GroupChatAddParticipantScreen(
                                roomName: widget.roomName),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            body: ListView(shrinkWrap: true, children: children),
          );
        }
        return CircularProgressIndicator(color: utilModel.greenColor);
      },
    );
  }
}
