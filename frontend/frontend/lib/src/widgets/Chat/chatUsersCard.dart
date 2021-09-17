import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/chatHelper.dart';
import 'package:frontend/src/helper/Chat/groupChatHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/screens/Chat/chatRoomScreen.dart';
import 'package:frontend/src/screens/Chat/chatViewUsersProfileScreen.dart';

class ChatUsersCard extends StatefulWidget {
  var groupChatHelper = GroupChatHelper();
  var decodedImage;
  final String displayName;
  final String displayImage;
  final int idUser;

  ChatUsersCard(
      {required this.displayName,
      required this.displayImage,
      required this.idUser,
      required this.groupChatHelper,
      this.decodedImage});

  @override
  _ChatUsersCardState createState() => _ChatUsersCardState();
}

class _ChatUsersCardState extends State<ChatUsersCard> {
  final utilModel = UtilModel();
  final chatHelper = ChatHelper();
  bool isSelected = false;
  bool hasNotifications = false;
  int notificationCount = 1;

  void toggle() {
    if (this.isSelected == false) {
      setState(
        () {
          this.isSelected = true;
          widget.groupChatHelper.addUserToArray(widget.idUser);
          print(widget.groupChatHelper.usersArray);
        },
      );
    } else if (this.isSelected == true) {
      setState(
        () {
          this.isSelected = false;
          widget.groupChatHelper.removeUserFromArray(widget.idUser);
          print(widget.groupChatHelper.usersArray);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        InkWell(
          onLongPress: () {
            toggle();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      border: isSelected
                          ? Border.all(
                              color: utilModel.greenColor,
                              width: 2,
                            )
                          : null,
                      borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatViewUsersProfileScreen(
                                idUser: widget.idUser),
                          ),
                        );
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
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatRoomScreen(widget.idUser),
                      ),
                    );
                  },
                  child: Text(
                    widget.displayName,
                    style: TextStyle(
                        fontSize: 25,
                        color:
                            isSelected ? utilModel.greenColor : Colors.white),
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
