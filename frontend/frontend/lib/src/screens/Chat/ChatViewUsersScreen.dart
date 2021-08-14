import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/widgets/Chat/chatUsersCard.dart';

class ChatViewUsersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _chatViewUserScreenState();
}

class _chatViewUserScreenState extends State<ChatViewUsersScreen> {
  final utilModel = UtilModel();
  final fireStoreHelper = FireStoreHelper();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: utilModel.greyColor,
        body: StreamBuilder<QuerySnapshot>(
          stream: fireStoreHelper.getUsersDocumentsFromFireStoreAsStream(),
          builder: (context, AsyncSnapshot snapshot) {
            List<Widget> children = [];
            if (snapshot.hasData) {
              for (int i = 0; i < snapshot.data.docs.length; i++) {
                children.add(ChatUsersCard(
                  displayName: snapshot.data.docs[i]['displayName'].toString(),
                  displayImage: snapshot.data.docs[i]['avatar'].toString(),
                  idUser: snapshot.data.docs[i]['uid'].toInt(),
                ));
              }
            } else {
              children.add(CircularProgressIndicator());
            }

            return ListView(children: children);
          },
        ),
      ),
    );
  }
}
