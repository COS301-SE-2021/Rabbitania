import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/widgets/Chat/groupChatAddUserCard.dart';

class GroupChatAddParticipantScreen extends StatefulWidget {
  final roomName;
  GroupChatAddParticipantScreen({required this.roomName});
  @override
  _GroupChatAddParticipantScreenState createState() =>
      _GroupChatAddParticipantScreenState();
}

class _GroupChatAddParticipantScreenState
    extends State<GroupChatAddParticipantScreen> {
  final firestoreHelper = FireStoreHelper();
  final utilModel = UtilModel();
  final userHelper = UserHelper();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userHelper.getUserID(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> futureSnapshot) {
        if (futureSnapshot.hasData) {
          int myId = futureSnapshot.data;
          return StreamBuilder(
            stream: firestoreHelper.getUsersDocumentsFromFireStoreAsStream(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                List<Widget> children = [];
                for (int i = 0; i < snapshot.data.docs.length; i++) {
                  var displayName =
                      snapshot.data.docs[i]['displayName'].toString();
                  var displayImage = snapshot.data.docs[i]['avatar'].toString();
                  var idUser = snapshot.data.docs[i]['uid'].toInt();
                  if (idUser != myId) {
                    children.add(
                      GroupChatAddUserCard(
                          displayName: displayName,
                          displayImage: displayImage,
                          idUser: idUser,
                          roomName: widget.roomName),
                    );
                  }
                }
                return Scaffold(
                  backgroundColor: utilModel.greyColor,
                  body: ListView(shrinkWrap: true, children: children),
                );
              }
              return Container(
                  width: 35,
                  height: 35,
                  child:
                      CircularProgressIndicator(color: utilModel.greenColor));
            },
          );
        }
        return Container(
            width: 35,
            height: 35,
            child: CircularProgressIndicator(color: utilModel.greenColor));
      },
    );
  }
}
