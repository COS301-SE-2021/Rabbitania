import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:frontend/src/widgets/Chat/chatUsersCard.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';

class ChatViewUsersScreen extends StatefulWidget {
  //id of currently logged in user
  //TODO:need to set up global accessor to get this value
  //1== runtimeTerrors , 2==James, 3==diff , 4==matt, 5==Dean, 6==Joe

  @override
  State<StatefulWidget> createState() => _chatViewUserScreenState();
}

class _chatViewUserScreenState extends State<ChatViewUsersScreen> {
  final userProvider = UserProvider();
  final utilModel = UtilModel();
  final fireStoreHelper = FireStoreHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            title: Center(
              child: Text(
                'Users',
                style: TextStyle(color: utilModel.greenColor, fontSize: 20),
              ),
            )),
        backgroundColor: utilModel.greyColor,
        body: FutureBuilder(
          future: userProvider.getUserID(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              int userId = snapshot.data;
              return StreamBuilder<QuerySnapshot>(
                stream:
                    fireStoreHelper.getUsersDocumentsFromFireStoreAsStream(),
                builder: (context, AsyncSnapshot snapshot) {
                  List<Widget> children = [];
                  if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data.docs.length; i++) {
                      if (snapshot.data.docs[i]['uid'] != userId) {
                        children.add(
                          ChatUsersCard(
                            displayName:
                                snapshot.data.docs[i]['displayName'].toString(),
                            displayImage:
                                snapshot.data.docs[i]['avatar'].toString(),
                            idUser: snapshot.data.docs[i]['uid'].toInt(),
                            myId: userId,
                          ),
                        );
                      }
                    }
                  } else {
                    children.add(CircularProgressIndicator());
                  }

                  return ListView(
                    shrinkWrap: true,
                    children: children,
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(color: utilModel.greenColor),
            );
          },
        ),
        bottomNavigationBar: bnb(context),
      ),
    );
  }
}
