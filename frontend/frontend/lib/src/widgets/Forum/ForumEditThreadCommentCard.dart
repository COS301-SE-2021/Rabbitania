import 'dart:convert';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/screens/Forum/forumCommentScreen.dart';
import 'package:frontend/src/screens/Forum/forumEditThreadCommentScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String>? futureEditThreadCommentString;

class ForumEditForumThreadCommentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: <Widget>[
        FutureBuilder<List<ThreadComments>>(
          future: futureThreadComments,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var iterate = snapshot.data!.iterator;
              List<Widget> cards = [];
              while (iterate.moveNext()) {
                if (iterate.current.forumThreadId == currentThreadID) {
                  return EditForumThreadCommentCard(
                    threadCommentId: iterate.current.threadCommentId,
                    commentBody: iterate.current.commentBody,
                    likes: iterate.current.likes,
                    dislikes: iterate.current.dislikes,
                    createdDate: iterate.current.createdDate,
                    userName: iterate.current.userName,
                    profilePicture: iterate.current.profilePicture,
                    imageURL: iterate.current.imageURL,
                    userId: iterate.current.userId,
                    forumThreadId: iterate.current.forumThreadId,
                  );
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
