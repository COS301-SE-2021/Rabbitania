import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Chat/groupChatViewGroupScreen.dart';
import 'package:frontend/src/widgets/Chat/groupChatUserAvatar.dart';

class GroupChatParticipantBar extends StatefulWidget {
  final String roomName;
  GroupChatParticipantBar({required this.roomName});
  @override
  _GroupChatParticipantBarState createState() =>
      _GroupChatParticipantBarState();
}

class _GroupChatParticipantBarState extends State<GroupChatParticipantBar> {
  final firestoreHelper = FireStoreHelper();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: firestoreHelper.getGroupRoomByRoomName(widget.roomName),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot1) {
          List<Widget> children = [
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GroupChatViewGroupScreen(roomName: widget.roomName),
                      ),
                    );
                  },
                  child: Text(
                    widget.roomName,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            )
          ];
          //loop through participants to get each user avatar and display in circleavatar
          if (snapshot1.hasData) {
            var participants = snapshot1.data.docs[0]['participants'];

            for (int i = 0; i < participants.length; i++) {
              children.add(StreamBuilder(
                stream: firestoreHelper.getUserById(participants[i]),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
                  if (snapshot2.hasData) {
                    var avatar = snapshot2.data.docs[0]['avatar'];
                    var uid = snapshot2.data.docs[0]['uid'];
                    return GroupChatUserAvatar(avatar: avatar, uid: uid);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ));
            }
          } else {
            return CircularProgressIndicator();
          }
          return SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child:
                ListView(scrollDirection: Axis.horizontal, children: children),
          );
        });
  }
}
