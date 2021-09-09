import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/chatHelper.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/helper/Chat/groupChatHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/widgets/Chat/chatMessageReceiver.dart';
import 'package:frontend/src/widgets/Chat/chatMessageSender.dart';
import 'package:frontend/src/widgets/Chat/groupChatMessageBar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/widgets/Chat/groupChatParticipantBar.dart';

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
  final chatHelper = ChatHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userHelper.getUserID(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          int myId = snapshot.data;
          return Scaffold(
            backgroundColor: utilModel.greyColor,
            appBar: AppBar(
              title: GroupChatParticipantBar(roomName: widget.roomName),
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
              backgroundColor: Colors.transparent,
            ),
            body: Stack(
              children: [
                SvgPicture.string(
                  utilModel.svg_background,
                  fit: BoxFit.contain,
                ),
                Column(
                  children: [
                    Expanded(
                      flex: 12,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 9,
                              child: StreamBuilder(
                                stream: fireStoreHelper
                                    .getGroupChatByRoomName(widget.roomName),
                                builder: (BuildContext context,
                                    AsyncSnapshot streamSnapshot) {
                                  List<Widget> children = [];
                                  if (streamSnapshot.hasData) {
                                    //must loop through messages return object to filter throug
                                    if (streamSnapshot.data.docs.length == 0) {
                                      children.add(
                                        Center(
                                          child: Text(
                                            "You have no chat history with this user. Why don't you say hi",
                                            style: TextStyle(
                                              color: utilModel.greenColor,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      for (int i = 0;
                                          i < streamSnapshot.data.docs.length;
                                          i++) {
                                        //messages correspond to current user and selected user

                                        if (streamSnapshot.data.docs[i]
                                                ['uid'] ==
                                            myId) {
                                          children.add(
                                            ChatMessageSender(
                                                textSentValue: streamSnapshot
                                                    .data.docs[i]['message'],
                                                timestamp: chatHelper
                                                    .dateFormater(streamSnapshot
                                                        .data
                                                        .docs[i]['dateCreated']
                                                        .toDate())),
                                          );
                                        } else if (streamSnapshot.data.docs[i]
                                                    ['uid'] !=
                                                myId &&
                                            streamSnapshot.data.docs[i]
                                                    ['uid'] !=
                                                -1) {
                                          print(streamSnapshot.data.docs[i]
                                              ['dateCreated']);
                                          children.add(
                                            ChatMessageReceiver(
                                                textSentValue: streamSnapshot
                                                    .data.docs[i]['message'],
                                                uid: streamSnapshot.data.docs[i]
                                                    ['uid'],
                                                timestamp: chatHelper
                                                    .dateFormater(streamSnapshot
                                                        .data
                                                        .docs[i]['dateCreated']
                                                        .toDate())),
                                          );
                                        } else {
                                          children.add(
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child: Center(
                                                child: Text(
                                                  streamSnapshot.data.docs[i]
                                                      ['message'],
                                                  style: TextStyle(
                                                      color:
                                                          utilModel.whiteColor,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  } else {
                                    children.add(CircularProgressIndicator());
                                  }

                                  //participantID matches clicked on id, means other persons message

                                  // return ListView(
                                  //     reverse: true, shrinkWrap: true, children: children);
                                  return ListView.builder(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    reverse: true,
                                    itemCount: children.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return children[index];
                                    },
                                  );
                                },
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10, right: 5, left: 5),
                      child: GroupChatSendMessageBar(myId, widget.roomName),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return Center(
            child: CircularProgressIndicator(color: utilModel.greenColor));
      },
    );
  }
}
