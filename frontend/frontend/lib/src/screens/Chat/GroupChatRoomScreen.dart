import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/widgets/Chat/chatMessageReceiver.dart';
import 'package:frontend/src/widgets/Chat/chatMessageSender.dart';
import 'package:frontend/src/widgets/Chat/groupChatMessageBar.dart';
import 'package:flutter_svg/svg.dart';

class GroupChatRoomScreen extends StatefulWidget {
  final String roomName;

  GroupChatRoomScreen(this.roomName);
  @override
  _GroupChatRoomScreenState createState() => _GroupChatRoomScreenState();
}

class _GroupChatRoomScreenState extends State<GroupChatRoomScreen> {
  final userHelper = UserHelper();
  final utilModel = UtilModel();
  final fireStoreHelper = FireStoreHelper();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userHelper.getUserID(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          int myId = snapshot.data;
          return Scaffold(
            backgroundColor: utilModel.greyColor,
            body: Column(
              children: [
                StreamBuilder(
                  stream:
                      fireStoreHelper.getGroupChatByRoomName(widget.roomName),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      List<Widget> children = [];
                      if (streamSnapshot.data.docs.length != 0) {
                        for (int i = 0;
                            i < streamSnapshot.data.docs.length;
                            i++) {
                          String message =
                              streamSnapshot.data.docs[i]['message'];
                          int uid = streamSnapshot.data.docs[i]['uid'];
                          if (uid == myId) {
                            children.add(
                              ChatMessageSender(
                                textSentValue: message,
                              ),
                            );
                          } else {
                            children.add(
                              ChatMessageReceiver(
                                textSentValue: message,
                              ),
                            );
                          }
                        }
                        return ListView(shrinkWrap: true, children: children);
                      }
                    }
                    return Center(
                      child: CircularProgressIndicator(
                          color: utilModel.greenColor),
                    );
                  },
                ),
              ],
            ),
            bottomNavigationBar: GroupChatSendMessageBar(myId, widget.roomName),
          );
        }
        return Container(
          width: 50,
          height: 50,
          child: Center(
              child: CircularProgressIndicator(color: utilModel.greenColor)),
        );
      },
    );
  }
}
