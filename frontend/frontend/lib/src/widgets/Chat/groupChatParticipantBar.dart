import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/models/util_model.dart';

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
          List<Widget> children = [];
          //loop through participants to get each user avatar and display in circleavatar
          if (snapshot1.hasData) {
            var participants = snapshot1.data.docs[0]['participants'];
            print(participants[0]);
            for (int i = 0; i < participants.length; i++) {
              children.add(StreamBuilder(
                stream: firestoreHelper.getUserById(participants[i]),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
                  if (snapshot2.hasData) {
                    var avatar = snapshot2.data.docs[0]['avatar'];
                    return CircleAvatar(
                      backgroundImage: NetworkImage(avatar),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ));
            }
          } else {
            return CircularProgressIndicator();
          }
          return Row(children: children);
        });
  }
}
