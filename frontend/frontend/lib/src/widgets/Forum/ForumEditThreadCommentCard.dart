import 'dart:convert';
import 'package:frontend/src/models/forumModel.dart';
import 'package:frontend/src/screens/Forum/forumCommentScreen.dart';
import 'package:frontend/src/screens/Forum/forumEditForumScreen.dart';
import 'package:frontend/src/screens/Forum/forumEditThreadCommentScreen.dart';
import 'package:frontend/src/screens/Forum/forumEditThreadScreen.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';
import 'package:frontend/src/screens/Forum/forumThreadScreen.dart';
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

class EditForumThreadCommentCard extends StatelessWidget {
  final int threadCommentId;
  final String commentBody;
  final String createdDate;
  final String imageURL;
  final int likes;
  final int dislikes;
  final String userName;
  final String profilePicture;
  final int forumThreadId;
  final int userId;

  const EditForumThreadCommentCard({
    required this.threadCommentId,
    required this.commentBody,
    required this.createdDate,
    required this.imageURL,
    required this.likes,
    required this.dislikes,
    required this.userName,
    required this.profilePicture,
    required this.forumThreadId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        child: Column(
          children: [
            TextFormField(
                style: TextStyle(color: Colors.white),
                controller: threadCommentBodyController,
                cursorColor: Color.fromRGBO(171, 255, 79, 1),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                  ),
                  labelText: 'Content',
                  labelStyle: TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                )),
          ],
        ),
      ),
    );
  }
}

Future<String> editForumThreadComment(String body) async {
  try {
    if (body == "") {
      throw ("Cannot Submit Empty Comment");
    }

    final response = await http.put(
      Uri.parse('https://10.0.2.2:5001/api/Forum/EditThreadComment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "threadCommentId": currentCommentId,
        "commentBody": body,
        "imageUrl": "image.png",
        "likes": 0,
        "dislikes": 0
      }),
    );
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 100) {
      return ("Successfully Edited Comment");
    } else {
      throw ("Failed To Edit Comment" + response.statusCode.toString());
    }
  } catch (Exception) {
    return Exception.toString();
  }
}
