import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/util_model.dart';

class GroupChatRoomScreen extends StatefulWidget {
  final String roomName;

  GroupChatRoomScreen(this.roomName);
  @override
  _GroupChatRoomScreenState createState() => _GroupChatRoomScreenState();
}

class _GroupChatRoomScreenState extends State<GroupChatRoomScreen> {
  final userHelper = UserHelper();
  final utilModel = UtilModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
        future: userHelper.getUserID(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {}
          return CircularProgressIndicator(color: utilModel.greenColor);
        },
      ),
    ));
  }
}
