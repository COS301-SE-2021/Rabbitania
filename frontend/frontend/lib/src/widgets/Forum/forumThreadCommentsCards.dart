import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/forum_provider.dart';
import 'package:frontend/src/screens/Forum/forumCommentScreen.dart';
import 'package:frontend/src/screens/Forum/forumEditThreadCommentScreen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

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
              children: <Widget>[Reactions(context)]),
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

Widget Reactions(BuildContext context) {
  return FlutterReactionButtonCheck(
    boxColor: Color.fromRGBO(33, 33, 33, 1),
    boxItemsSpacing: 7,
    boxPadding: EdgeInsets.only(top: 3, bottom: 3, left: 3),
    onReactionChanged: (reaction, index, isChecked) {
      print('reaction selected index: $index');
    },
    reactions: <Reaction>[
      Reaction(
        previewIcon: Icon(Icons.thumb_up_alt_rounded,
            size: 50, color: Color.fromRGBO(175, 255, 79, 1)),
        icon: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.06, bottom: 10),
          child: Icon(Icons.thumb_up_alt_rounded,
              size: 25, color: Color.fromRGBO(175, 255, 79, 1)),
        ),
      ),
      Reaction(
        previewIcon:
            Icon(Icons.thumb_down_alt_rounded, size: 50, color: Colors.red),
        icon: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.06, bottom: 10),
          child:
              Icon(Icons.thumb_down_alt_rounded, size: 25, color: Colors.red),
        ),
      ),
      Reaction(
        previewIcon: Icon(Icons.emoji_emotions,
            size: 50, color: Color.fromRGBO(175, 255, 79, 1)),
        icon: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.06, bottom: 10),
          child: Icon(Icons.emoji_emotions,
              size: 25, color: Color.fromRGBO(175, 255, 79, 1)),
        ),
      ),
      Reaction(
        previewIcon: Icon(Icons.people,
            size: 50, color: Color.fromRGBO(175, 255, 79, 1)),
        icon: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.06, bottom: 10),
          child: Icon(Icons.people,
              size: 25, color: Color.fromRGBO(175, 255, 79, 1)),
        ),
      ),
      Reaction(
        previewIcon:
            Icon(Icons.pets, size: 50, color: Color.fromRGBO(175, 255, 79, 1)),
        icon: Container(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.06, bottom: 10),
          child: Icon(Icons.pets,
              size: 25, color: Color.fromRGBO(175, 255, 79, 1)),
        ),
      ),
    ],
    initialReaction: Reaction(
      icon: Container(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.06, bottom: 10),
        child: Icon(Icons.add_reaction_outlined,
            size: 25, color: Color.fromRGBO(175, 255, 79, 1)),
      ),
    ),
    selectedReaction: Reaction(
      icon: Container(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.06, bottom: 10),
        child: Icon((Icons.thumb_up_alt_rounded),
            size: 25, color: Color.fromRGBO(175, 255, 79, 1)),
      ),
    ),
  );
}
