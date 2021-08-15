import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/widgets/Chat/chatMessageReceiver.dart';
import 'package:frontend/src/widgets/Chat/chatMessageSender.dart';
import 'package:frontend/src/widgets/Chat/chatParticipantBar.dart';
import 'package:frontend/src/widgets/Chat/chatSendMessageBar.dart';
import 'package:rxdart/rxdart.dart';

class ChatRoomScreen extends StatefulWidget {
  final idUser;
  //1== runtimeTerrors , 2==James, 3==diff , 4==matt, 5==Dean, 6==Joe
  final int myId = 6;
  //i am currently retard
  // final int myId = 2
  ChatRoomScreen(this.idUser);
  @override
  State<StatefulWidget> createState() => _chatRoomScreenState();
}

class _chatRoomScreenState extends State<ChatRoomScreen> {
  final fireStoreHelper = FireStoreHelper();
  final utilModel = UtilModel();

  @override
  Widget build(BuildContext context) {
    //TODO: must filter to only see messages sent to current user
    return Scaffold(
      backgroundColor: utilModel.greyColor,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: ChatParticipantBar(widget.idUser),
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
                        stream:
                            fireStoreHelper.getChat(widget.idUser, widget.myId),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          print(widget.idUser);

                          List<Widget> children = [];
                          if (snapshot.hasData) {
                            //must loop through messages return object to filter throug
                            if (snapshot.data.docs.length == 0) {
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
                                  i < snapshot.data.docs.length;
                                  i++) {
                                //messages correspond to current user and selected user

                                if (snapshot.data.docs[i]['uid'] ==
                                    widget.myId) {
                                  children.add(ChatMessageSender(
                                      textSentValue: snapshot.data.docs[i]
                                          ['message']));
                                } else if (snapshot.data.docs[i]['uid'] ==
                                    widget.idUser) {
                                  children.add(
                                    ChatMessageReceiver(
                                      textSentValue: snapshot.data.docs[i]
                                          ['message'],
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
                            reverse: true,
                            itemCount: children.length,
                            itemBuilder: (BuildContext context, int index) {
                              return children[index];
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 10, right: 5, left: 5),
                        child: ChatSendMessageBar(widget.idUser, widget.myId),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
