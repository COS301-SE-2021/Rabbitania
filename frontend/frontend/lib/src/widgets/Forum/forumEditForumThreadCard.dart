import 'dart:io';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/provider/forum_provider.dart';
import 'package:frontend/src/screens/Forum/forumThreadScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

File? editForumThreadImageFile;
String editForumThreadInputImage = "";
String editForumThreadImg64 = "";

class ForumEditForumThreadCard extends StatelessWidget {
  final ForumThreadProvider ForumEditThreadProvider = new ForumThreadProvider();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: <Widget>[
        FutureBuilder<List<ForumThread>>(
          future: ForumEditThreadProvider.fetchForumThreads(currentForumID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var iterate = snapshot.data!.iterator;
              List<Widget> cards = [];
              while (iterate.moveNext()) {
                if (iterate.current.forumThreadId == currentThreadID) {
                  return EditForumThreadCard(
                      forumThreadId: iterate.current.forumThreadId,
                      forumThreadTitle: iterate.current.forumThreadTitle,
                      forumThreadBody: iterate.current.forumThreadBody,
                      createdDate: iterate.current.createdDate,
                      imageURL: iterate.current.imageURL,
                      userId: iterate.current.userId);
                }
              }
              return new Column(children: cards);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator(
              color: Color.fromRGBO(171, 255, 79, 1),
            );
          },
        ),
      ]),
    );
  }
}
