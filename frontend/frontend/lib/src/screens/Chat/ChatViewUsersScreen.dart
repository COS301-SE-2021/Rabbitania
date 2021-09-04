import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/helper/Chat/groupChatHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:frontend/src/widgets/Chat/chatUsersCard.dart';
import 'package:frontend/src/widgets/Chat/groupChatCard.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';

import 'groupChatCreateScreen.dart';

class ChatViewUsersScreen extends StatefulWidget {
  //id of currently logged in user
  //TODO:need to set up global accessor to get this value
  //1== runtimeTerrors , 2==James, 3==diff , 4==matt, 5==Dean, 6==Joe

  @override
  State<StatefulWidget> createState() => _chatViewUserScreenState();
}

class _chatViewUserScreenState extends State<ChatViewUsersScreen> {
  final groupChatHelper = GroupChatHelper();
  final userProvider = UserProvider();
  final utilModel = UtilModel();
  final fireStoreHelper = FireStoreHelper();
  bool visible = false;
  _chatViewUserScreenState() {
    this.groupChatHelper.addListener(() {
      print(this.groupChatHelper.usersArray.length);
      print(this.visible);
      if (this.groupChatHelper.usersArray.length < 2) {
        setState(() {
          this.visible = false;
        });
      } else if (this.groupChatHelper.usersArray.length > 1) {
        setState(() {
          this.visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              'Users',
              style: TextStyle(color: utilModel.greenColor, fontSize: 35),
            ),
          ),
        ),
        backgroundColor: utilModel.greyColor,
        body: Column(
          children: [
            FutureBuilder(
              future: userProvider.getUserID(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  int myId = snapshot.data;
                  //users streambuilder
                  return StreamBuilder<QuerySnapshot>(
                    stream: fireStoreHelper
                        .getUsersDocumentsFromFireStoreAsStream(),
                    builder: (context, AsyncSnapshot snapshot1) {
                      //groups streambuilder
                      return StreamBuilder(
                        stream: fireStoreHelper.getGroupChats(myId),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot2) {
                          List<Widget> children = [];
                          if (snapshot1.hasData && snapshot2.hasData) {
                            for (int i = 0;
                                i < snapshot1.data.docs.length;
                                i++) {
                              if (snapshot1.data.docs[i]['uid'] != myId) {
                                children.add(
                                  ChatUsersCard(
                                      displayName: snapshot
                                          .data.docs[i]['displayName']
                                          .toString(),
                                      displayImage: snapshot
                                          .data.docs[i]['avatar']
                                          .toString(),
                                      idUser:
                                          snapshot.data.docs[i]['uid'].toInt(),
                                      myId: myId,
                                      groupChatHelper: this.groupChatHelper),
                                );
                              }
                            }
                          } else {
                            children.add(CircularProgressIndicator());
                          }
                          return ListView(shrinkWrap: true, children: children);
                        },
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(color: utilModel.greenColor),
                );
              },
            ),
          ],
        ),
        floatingActionButton: Visibility(
          visible: this.visible,
          child: IconButton(
            icon: Icon(FontAwesomeIcons.users, color: utilModel.greenColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupChatCreateScreen(
                      groupChatHelper: this.groupChatHelper),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: bnb(context),
      ),
    );
  }
}
