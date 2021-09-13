import 'package:flutter/material.dart';
import 'package:frontend/src/screens/Chat/ChatRoomScreen.dart';
import 'package:frontend/src/screens/Chat/ChatViewUsersProfileScreen.dart';

class GroupChatUserAvatar extends StatefulWidget {
  final avatar;
  final uid;
  GroupChatUserAvatar({required this.avatar, required this.uid});

  @override
  _GroupChatUserAvatarState createState() => _GroupChatUserAvatarState();
}

class _GroupChatUserAvatarState extends State<GroupChatUserAvatar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ChatViewUsersProfileScreen(idUser: widget.uid),
            ),
          );
        },
        onLongPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoomScreen(widget.uid),
            ),
          );
        },
        child: CircleAvatar(
          backgroundImage: NetworkImage(widget.avatar),
        ),
      ),
    );
  }
}
