import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/chatHelper.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/models/utilModel.dart';

class GroupChatAddUserCard extends StatefulWidget {
  final roomName;
  final String displayName;
  final String displayImage;
  final int idUser;

  GroupChatAddUserCard(
      {required this.displayName,
      required this.displayImage,
      required this.idUser,
      required this.roomName});

  @override
  _GroupChatAddUserCardState createState() => _GroupChatAddUserCardState();
}

class _GroupChatAddUserCardState extends State<GroupChatAddUserCard> {
  final utilModel = UtilModel();
  final chatHelper = ChatHelper();
  final firestoreHelper = FireStoreHelper();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        InkWell(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () async {
                        await firestoreHelper.sendGroupChatMessage(
                            widget.roomName,
                            -1,
                            '${widget.displayName} has joined ${widget.roomName}');
                        await firestoreHelper.addUserToGroup(
                            widget.roomName, widget.idUser);
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.displayImage),
                        radius: 30,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: InkWell(
                  radius: MediaQuery.of(context).size.width,
                  splashColor: utilModel.greenColor,
                  onTap: () async {
                    await firestoreHelper.sendGroupChatMessage(
                        widget.roomName,
                        -1,
                        '${widget.displayName} has joined ${widget.roomName}');
                    await firestoreHelper.addUserToGroup(
                        widget.roomName, widget.idUser);
                    Navigator.pop(context);
                  },
                  child: Text(
                    widget.displayName,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
