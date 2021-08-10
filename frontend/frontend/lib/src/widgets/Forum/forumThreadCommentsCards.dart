import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/forumModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Forum/forumCommentScreen.dart';
import 'package:frontend/src/screens/Forum/forumThreadScreen.dart';
import 'package:frontend/src/widgets/Forum/forumLatestThread.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;

class ForumThreadCommentsCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ThreadComments>>(
      future: futureThreadComments,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var iterate = snapshot.data!.iterator;
          if (snapshot.data!.length == 0) {
            return Card(
              color: Color.fromRGBO(57, 57, 57, 25),
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.only(
                        bottom: 5.0, top: 10, left: 20, right: 10),
                    title: Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "No Comments",
                        style: TextStyle(
                            letterSpacing: 2.0,
                            color: Colors.white,
                            fontSize: 22),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            List<Widget> comments = [];
            while (iterate.moveNext()) {
              comments.add(forumCommentCard(
                  threadCommentId: iterate.current.threadCommentId,
                  commentBody: iterate.current.commentBody,
                  createdDate: iterate.current.createdDate,
                  imageURL: iterate.current.imageURL,
                  likes: iterate.current.likes,
                  dislikes: iterate.current.dislikes,
                  userName: iterate.current.userName,
                  profilePicture: iterate.current.profilePicture,
                  forumThreadId: iterate.current.forumThreadId,
                  userId: iterate.current.userId));
            }
            return new ListView(children: comments);
          }
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircularProgressIndicator(
              color: Color.fromRGBO(171, 255, 79, 1),
            )
          ]);
        }
      },
    );
  }
}

class forumCommentCard extends StatelessWidget {
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

  const forumCommentCard({
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
    return new Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: new Container(
        color: Color.fromRGBO(57, 57, 57, 1),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          new ListTile(
            leading: new CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(profilePicture),
              backgroundColor: Color.fromRGBO(171, 255, 79, 1),
              foregroundColor: Colors.white,
            ),
            title: new Text(
              userName,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              commentBody,
              style: TextStyle(color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextButton.icon(
                  label: Text(likes.toString(),
                      style: TextStyle(color: Color.fromRGBO(175, 255, 79, 1))),
                  icon: const Icon(Icons.thumb_up_alt_rounded,
                      size: 20, color: Color.fromRGBO(175, 255, 79, 1)),
                  onPressed: () {},
                  //   style: ButtonStyle(
                  //       //backgroundColor:
                  //           //MaterialStateProperty.all<Color>(Colors.green)),
                ),
                TextButton.icon(
                  label: Text(dislikes.toString(),
                      style: TextStyle(color: Colors.red)),
                  icon: const Icon(Icons.thumb_down_alt_rounded,
                      size: 20, color: Colors.red),
                  onPressed: () {},
                ),
              ]),
          new Divider(
            height: 0.0,
            thickness: 0.3,
            color: Colors.black,
          ),
        ]),
      ),
      actions: <Widget>[
        new IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => {},
        ),
      ],
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: 'Edit',
          color: Color.fromRGBO(171, 255, 79, 1),
          icon: Icons.edit,
          onTap: () => {},
        ),
      ],
    );
  }
}

Future<String> addNewComment(String comment) async {
  try {
    if (comment == "") {
      throw ("Cannot Submit Empty Fields");
    }

    final response = await http.post(
      Uri.parse('https://10.0.2.2:5001/api/Forum/CreateThreadComment'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "threadCommentId": 0,
        "commentBody": comment,
        "createdDate": "2021-08-10T12:28:13.364Z",
        "imageUrl": "string",
        "likes": 0,
        "dislikes": 0,
        "userId": 8,
        "forumThreadId": currentThreadID
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return ("Success");
    } else {
      throw ("Failed to Send Message" + response.statusCode.toString());
    }
  } catch (Exception) {
    return ("Error: " + Exception.toString());
  }
}
