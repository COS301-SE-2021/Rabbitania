import 'package:flutter/material.dart';

class GroupChatCard extends StatefulWidget {
  final roomName;
  GroupChatCard(this.roomName);

  @override
  _GroupChatCardState createState() => _GroupChatCardState();
}

class _GroupChatCardState extends State<GroupChatCard> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text('${widget.roomName}'),
    ]);
  }
}
