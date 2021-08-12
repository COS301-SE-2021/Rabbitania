import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/forum_provider.dart';
import 'package:frontend/src/screens/Forum/forumCommentScreen.dart';
import 'package:frontend/src/screens/Forum/forumEditThreadScreen.dart';
import 'package:frontend/src/screens/Forum/forumThreadScreen.dart';
import 'package:frontend/src/widgets/Forum/forumLatestThread.dart';

class ForumThreadsCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
          //Top to bottom View
          padding: EdgeInsets.only(bottom: 70),
          children: <Widget>[
            //Children in the list

            FutureBuilder<List<ForumThread>>(
              future: futureForumThreads,
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
                                "No Threads Currently In " + currentForumName,
                                style: TextStyle(
                                    letterSpacing: 2.0,
                                    color: Colors.white,
                                    fontSize: 22),
                              ),
                            ),
                            subtitle: Text(
                              "New Threads Will Be Posted Here",
                              style: TextStyle(color: Colors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    List<Widget> cards = [];
                    while (iterate.moveNext()) {
                      cards.add(forumThreadCard(
                          forumThreadId: iterate.current.forumThreadId,
                          forumThreadTitle: iterate.current.forumThreadTitle,
                          forumThreadBody: iterate.current.forumThreadBody,
                          createdDate: iterate.current.createdDate,
                          imageURL: iterate.current.imageURL,
                          userId: iterate.current.userId));
                    }
                    return new Column(children: cards);
                  }
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return CircularProgressIndicator(
                    color: Color.fromRGBO(171, 255, 79, 1),
                  );
                }
              },
            ),
          ]),
    );
  }
}

class forumThreadCard extends StatelessWidget {
  final int forumThreadId;
  final String forumThreadTitle;
  final String forumThreadBody;
  final String createdDate;
  final String imageURL;
  final int userId;

  const forumThreadCard(
      {required this.forumThreadId,
      required this.forumThreadTitle,
      required this.forumThreadBody,
      required this.createdDate,
      required this.imageURL,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return new Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: new Container(
        padding: EdgeInsets.only(bottom: 0, top: 0),
        child: InkWell(
          onTap: () {
            currentThreadID = this.forumThreadId;
            currentThreadName = this.forumThreadTitle;
            currentThreadBody = this.forumThreadBody;
            currentThreadImage = this.imageURL;
            UtilModel.route(() => ForumCommentScreen(), context);
          },
          child: Card(
            color: Color.fromRGBO(57, 57, 57, 100),
            shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            clipBehavior: Clip.antiAlias,
            elevation: 2,
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.only(
                      bottom: 10.0, top: 10, left: 20, right: 10),
                  title: Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      forumThreadTitle,
                      style: TextStyle(
                          letterSpacing: 2.0,
                          color: Colors.white,
                          fontSize: 22),
                    ),
                  ),
                  subtitle: Text(
                    forumThreadBody,
                    style: TextStyle(color: Colors.white),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Container(
                    constraints: const BoxConstraints(
                        minWidth: 100,
                        maxWidth: 100,
                        minHeight: 300.0,
                        maxHeight: 300),
                    padding: EdgeInsets.only(top: 0),
                    child: Image.memory(Base64Decoder().convert(imageURL),
                        fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ),
        ),
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
                  title: Text("Delete Thread"),
                  contentTextStyle:
                      TextStyle(color: Colors.white, fontSize: 16),
                  content: Text("Are you sure you want to delete this Thread?"),
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.check,
                        color: Color.fromRGBO(171, 255, 79, 1),
                        size: 24.0,
                      ),
                      tooltip: 'Delete',
                      onPressed: () async {
                        currentThreadID = this.forumThreadId;
                        await deleteForumThread(currentThreadID);
                        UtilModel.route(() => ForumThreadScreen(), context);
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
            currentThreadID = this.forumThreadId;
            //currentCommentBody = this.commentBody;
            UtilModel.route(() => ForumEditThreadScreen(), context);
          },
        ),
      ],
    );
  }
}
