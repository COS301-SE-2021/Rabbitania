import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/helper/Chat/chatHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Chat/ChatRoomScreen.dart';
import 'package:frontend/src/widgets/Profile/profile_picture_widget.dart';

class ChatUsersCard extends StatefulWidget {
  final String displayName;
  final String displayImage;
  final int idUser;

  ChatUsersCard(
      {required this.displayName,
      required this.displayImage,
      required this.idUser});

  @override
  _ChatUsersCardState createState() => _ChatUsersCardState();
}

class _ChatUsersCardState extends State<ChatUsersCard> {
  final utilModel = UtilModel();
  final chatHelper = ChatHelper();

  bool isSelected = false;
  //TODO: create function for setting hasNotification to true if count > 0
  bool hasNotifications = true;
  //TODO: make to get notification count with http to server
  int notificatioCount = 1;
  void toggle() {
    if (this.isSelected) {
      setState(() {
        this.isSelected = false;
      });
    } else {
      setState(() {
        this.isSelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onLongPress: () {
            toggle();
            //add user to list of selcted users
          },
          onTap: () {
            //navigate to chatScreen when clicked
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoomScreen(widget.idUser),
              ),
            );
          },
          splashColor: utilModel.greenColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //profile picture of the user

              Container(
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
                  child: CircleAvatar(
                    //backgroundColor: utilModel.greenColor,
                    backgroundImage: NetworkImage(widget.displayImage),
                    radius: 35,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Text(
                  widget.displayName,
                  style: TextStyle(
                      fontSize: 35,
                      color: isSelected ? utilModel.greenColor : Colors.white),
                ),
              ),
              Visibility(
                visible: this.hasNotifications,
                child: Container(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundColor: utilModel.greenColor,
                      //backgroundColor: utilModel.greenColor,
                      child: Text(
                        notificatioCount.toString(),
                        style: TextStyle(
                            color: utilModel.greyColor,
                            fontWeight: FontWeight.bold),
                      ),
                      radius: 12,
                    ),
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
