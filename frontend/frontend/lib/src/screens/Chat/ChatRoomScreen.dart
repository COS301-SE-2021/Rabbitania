import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/chatHelper.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:frontend/src/widgets/Chat/chatMessageReceiver.dart';
import 'package:frontend/src/widgets/Chat/chatMessageSender.dart';
import 'package:frontend/src/widgets/Chat/chatParticipantBar.dart';
import 'package:frontend/src/widgets/Chat/chatSendMessageBar.dart';

class ChatRoomScreen extends StatefulWidget {
  final idUser;
  ChatRoomScreen(this.idUser);
  @override
  State<StatefulWidget> createState() => _chatRoomScreenState();
}

class _chatRoomScreenState extends State<ChatRoomScreen> {
  final fireStoreHelper = FireStoreHelper();
  final utilModel = UtilModel();
  final userProvider = UserProvider();
  final chatHelper = ChatHelper();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userProvider.getUserID(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          int myId = snapshot.data;
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
                  utilModel.svgBackground,
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
                                stream: fireStoreHelper.getChat(
                                    widget.idUser, myId),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  print(widget.idUser);

                                  List<Widget> children = [];
                                  if (snapshot.hasData) {
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
                                        if (snapshot.data.docs[i]['uid'] ==
                                                myId &&
                                            snapshot.data.docs[i]['toUid'] ==
                                                widget.idUser) {
                                          children.add(
                                            ChatMessageSender(
                                              textSentValue: snapshot
                                                  .data.docs[i]['message'],
                                              timestamp: chatHelper
                                                  .dateFormater(snapshot.data
                                                      .docs[i]['dateCreated']
                                                      .toDate()),
                                            ),
                                          );
                                        } else if (snapshot.data.docs[i]
                                                    ['uid'] ==
                                                widget.idUser &&
                                            snapshot.data.docs[i]['toUid'] ==
                                                myId) {
                                          children.add(
                                            ChatMessageReceiver(
                                              textSentValue: snapshot
                                                  .data.docs[i]['message'],
                                              timestamp: chatHelper
                                                  .dateFormater(snapshot.data
                                                      .docs[i]['dateCreated']
                                                      .toDate()),
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  } else {
                                    children.add(CircularProgressIndicator());
                                  }

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
                        margin:
                            const EdgeInsets.only(top: 10, right: 5, left: 5),
                        child: ChatSendMessageBar(widget.idUser, myId)),
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
