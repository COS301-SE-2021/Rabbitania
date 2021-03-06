import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/screens/Chat/groupChatRoomScreen.dart';

class GroupChatCard extends StatefulWidget {
  final String avatar;
  final String roomName;
  GroupChatCard({required this.avatar, required this.roomName});

  @override
  _GroupChatCardState createState() => _GroupChatCardState();
}

class _GroupChatCardState extends State<GroupChatCard> {
  final utilModel = UtilModel();
  final userHelper = UserHelper();
  final firestoreHelper = FireStoreHelper();
  var deleteVisible = false;
  decodeBase64(String base64Image) {
    return Image.memory(
      Base64Decoder().convert(base64Image),
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        deleteVisible
            ? setState(() {
                this.deleteVisible = false;
              })
            : setState(() {
                this.deleteVisible = true;
              });
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupChatRoomScreen(widget.roomName),
          ),
        );
      },
      child: Row(
        children: [
          SizedBox(width: 30.0),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: SizedBox(
              height: 60.0,
              width: 60.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(72),
                child: decodeBase64(this.widget.avatar),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              this.widget.roomName,
              style: TextStyle(
                color: utilModel.whiteColor,
                fontSize: 25,
              ),
              maxLines: 2,
            ),
          ),
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.centerRight,
              child: Visibility(
                visible: deleteVisible,
                child: IconButton(
                  icon:
                      Icon(FontAwesomeIcons.trash, color: utilModel.greenColor),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FutureBuilder(
                            future: userHelper.getUserID(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                int myId = snapshot.data;
                                return StreamBuilder(
                                    stream: firestoreHelper.getUserById(myId),
                                    builder: (context,
                                        AsyncSnapshot<dynamic> streamSnapshot) {
                                      if (streamSnapshot.hasData) {
                                        var displayName = streamSnapshot
                                            .data.docs[0]['displayName'];
                                        return AlertDialog(
                                          elevation: 5,
                                          backgroundColor:
                                              Color.fromRGBO(33, 33, 33, 1),
                                          titleTextStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 32),
                                          contentTextStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                          title: Text('Delete Group'),
                                          content: Text(
                                              'Are you sure you want to leave this group?'),
                                          actions: [
                                            IconButton(
                                              onPressed: () async {
                                                await firestoreHelper
                                                    .sendGroupChatMessage(
                                                        widget.roomName,
                                                        -1,
                                                        '$displayName has left ${widget.roomName}');
                                                await firestoreHelper
                                                    .removeUserFromGroup(
                                                        widget.roomName, myId);
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.check,
                                                  color: utilModel.greenColor),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.close,
                                                  color: Colors.red),
                                            ),
                                          ],
                                        );
                                      }
                                      return Container(
                                          width: 35,
                                          height: 35,
                                          child: CircularProgressIndicator());
                                    });
                              }
                              return Container(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                    color: utilModel.greenColor),
                              );
                            },
                          );
                        });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
