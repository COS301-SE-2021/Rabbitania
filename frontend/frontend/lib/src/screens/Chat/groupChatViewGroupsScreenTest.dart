import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/widgets/Chat/groupChatCard.dart';

class GroupChatViewGroupsScreenTest extends StatefulWidget {
  @override
  _GroupChatViewGroupsScreenTestState createState() =>
      _GroupChatViewGroupsScreenTestState();
}

class _GroupChatViewGroupsScreenTestState
    extends State<GroupChatViewGroupsScreenTest> {
  final utilModel = UtilModel();
  final userHelper = UserHelper();
  final firestoreHelper = FireStoreHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('ChatViewGroupScreenTest',
              style: TextStyle(color: utilModel.greenColor)),
        ),
        backgroundColor: utilModel.greyColor,
        body: FutureBuilder(
          future: userHelper.getUserID(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              int myId = snapshot.data;
              return StreamBuilder(
                stream: firestoreHelper.getGroupChats(myId),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  List<Widget> children = [];
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data.docs.length; i++) {
                      var avatar = snapshot.data.docs[i]['avatar'];
                      var roomName = snapshot.data.docs[i]['roomName'];
                      children.add(
                          GroupChatCard(avatar: avatar, roomName: roomName));
                    }
                  }
                  return ListView(children: children);
                },
              );
            }
            return Align();
          },
        ));
  }
}
