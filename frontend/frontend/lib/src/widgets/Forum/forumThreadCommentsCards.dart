import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/forumModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Forum/forumCommentScreen.dart';
import 'package:frontend/src/screens/Forum/forumEditThreadCommentScreen.dart';
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
            return ListView(children: [
              CurrentQuestionWidget(),
              Card(
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
              )
            ]);
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
            comments.add(CurrentQuestionWidget());
            return new ListView(children: comments.reversed.toList());
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

Widget CurrentQuestionWidget() {
  return Card(
    color: Color.fromRGBO(57, 57, 57, 25),
    shadowColor: Colors.black,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
    clipBehavior: Clip.antiAlias,
    elevation: 2,
    child: Column(
      children: <Widget>[
        Container(
          child: ListTile(
            contentPadding:
                EdgeInsets.only(bottom: 5.0, top: 10, left: 20, right: 10),
            title: Container(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                currentThreadName,
                style: TextStyle(
                    letterSpacing: 2.0, color: Colors.white, fontSize: 22),
              ),
            ),
            subtitle: Text(
              currentThreadBody,
              style: TextStyle(color: Colors.white),
              maxLines: 20,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Container(
          constraints: const BoxConstraints(
            minWidth: 0,
            maxWidth: double.infinity,
            minHeight: 0.0,
            maxHeight: double.infinity,
          ),
          padding: EdgeInsets.only(top: 5),
          child: Image.memory(Base64Decoder().convert(currentThreadImage),
              fit: BoxFit.cover, width: 10000),
        ),
      ],
    ),
  );
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
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  elevation: 5,
                  backgroundColor: Color.fromRGBO(33, 33, 33, 1),
                  titleTextStyle: TextStyle(color: Colors.white, fontSize: 32),
                  title: Text("Delete Comment"),
                  contentTextStyle:
                      TextStyle(color: Colors.white, fontSize: 16),
                  content:
                      Text("Are you sure you want to delete this Comment?"),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.check,
                        color: Color.fromRGBO(171, 255, 79, 1),
                        size: 24.0,
                      ),
                      tooltip: 'Delete',
                      onPressed: () async {
                        // ignore: unused_local_variable
                        currentCommentId = this.threadCommentId;
                        await deleteComment(currentCommentId);
                        UtilModel.route(() => ForumCommentScreen(), context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Color.fromRGBO(255, 79, 79, 1),
                        size: 24.0,
                      ),
                      tooltip: 'Cancel',
                      onPressed: () {
                        //final deleteResponse = await deleteThread(this.id);
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
      secondaryActions: <Widget>[
        new IconSlideAction(
          caption: 'Edit',
          color: Color.fromRGBO(171, 255, 79, 1),
          icon: Icons.edit,
          onTap: () {
            currentCommentId = this.threadCommentId;
            currentCommentBody = this.commentBody;
            UtilModel.route(() => ForumEditThreadCommentScreen(), context);
          },
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
