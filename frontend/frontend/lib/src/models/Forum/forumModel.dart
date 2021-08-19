import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:frontend/src/helper/Forum/forumHelper.dart';
import 'package:frontend/src/provider/forum_provider.dart';
import 'package:frontend/src/screens/Forum/forumCommentScreen.dart';
import 'package:frontend/src/screens/Forum/forumCreateForumScreen.dart';
import 'package:frontend/src/screens/Forum/forumEditForumScreen.dart';
import 'package:frontend/src/screens/Forum/forumEditThreadCommentScreen.dart';
import 'package:frontend/src/screens/Forum/forumEditThreadScreen.dart';
import 'package:frontend/src/screens/Forum/forumThreadScreen.dart';
import 'package:frontend/src/widgets/Forum/forumEditForumThreadCard.dart';
import 'package:frontend/src/widgets/Forum/forumLatestThread.dart';
import '../util_model.dart';

//GLOBAL VARIABLES
var currentForumID = -1;
var currentForumName = "ForumName";
var currentThreadID = -1;
var currentThreadName = "ThreadName";
var currentThreadBody = "Body";
var currentCommentId = -1;
var currentCommentBody = "Body";
var currentThreadImage = "";
//

////////////////////////////////////////////////////////////////
/// Forum Getting Forums
///////////////////////////////////////////////////////////////
class ForumObjs {
  final List<dynamic> forumThreadList;

  ForumObjs({
    required this.forumThreadList,
  });

  factory ForumObjs.fromJson(Map<String, dynamic> json) {
    return ForumObjs(
      forumThreadList: json["forums"],
    );
  }
}

class ForumObj {
  final int forumId;
  final String forumTitle;
  final String createdDate;
  final int userId;

  ForumObj({
    required this.forumId,
    required this.forumTitle,
    required this.createdDate,
    required this.userId,
  });

  factory ForumObj.fromJson(Map<String, dynamic> json) {
    return ForumObj(
      forumId: json['forumId'],
      forumTitle: json['forumTitle'],
      createdDate: json['createdDate'],
      userId: json['userId'],
    );
  }
}

////////////////////////////////////////////////////////////////
/// Forum Getting Forum Threads
///////////////////////////////////////////////////////////////
class ForumThreads {
  final List<dynamic>? forumThreadList;

  ForumThreads({
    required this.forumThreadList,
  });

  factory ForumThreads.fromJson(Map<String, dynamic> json) {
    return ForumThreads(
      forumThreadList: json["forumThreads"],
    );
  }
}

class ForumThread {
  final int forumThreadId;
  final String forumThreadTitle;
  final String forumThreadBody;
  final String createdDate;
  final String imageURL;
  final int forumId;
  final String? forum;
  final int userId;
  final String? user;

  ForumThread({
    required this.forumThreadId,
    required this.forumThreadTitle,
    required this.forumThreadBody,
    required this.createdDate,
    required this.imageURL,
    required this.forumId,
    required this.forum,
    required this.userId,
    required this.user,
  });

  factory ForumThread.fromJson(Map<String, dynamic> json) {
    return ForumThread(
      forumThreadId: json['forumThreadId'],
      forumThreadTitle: json['forumThreadTitle'],
      forumThreadBody: json['forumThreadBody'],
      createdDate: json['createdDate'],
      imageURL: json['imageURL'],
      forumId: json['forumId'],
      forum: json['forum'],
      userId: json['userId'],
      user: json['user'],
    );
  }
}

//////////////////////////
///ForumThreadComments:
/////////////////////////

class ForumThreadComments {
  final List<dynamic>? forumCommentsList;

  ForumThreadComments({
    required this.forumCommentsList,
  });

  factory ForumThreadComments.fromJson(Map<String, dynamic> json) {
    return ForumThreadComments(
      forumCommentsList: json["threadComments"],
    );
  }
}

class ThreadComments {
  final int threadCommentId;
  final String commentBody;
  final String createdDate;
  final String imageURL;
  final int likes;
  final int dislikes;
  final String userName;
  final String profilePicture;
  final int forumThreadId;
  final String? forumThread;
  final int userId;
  final String? user;

  ThreadComments(
      {required this.threadCommentId,
      required this.commentBody,
      required this.createdDate,
      required this.imageURL,
      required this.likes,
      required this.dislikes,
      required this.userName,
      required this.profilePicture,
      required this.forumThreadId,
      required this.forumThread,
      required this.userId,
      required this.user});

  factory ThreadComments.fromJson(Map<String, dynamic> json) {
    return ThreadComments(
        threadCommentId: json['threadCommentId'],
        commentBody: json['commentBody'],
        createdDate: json['createdDate'],
        imageURL: json['imageURL'],
        likes: json['likes'],
        dislikes: json['dislikes'],
        userName: json['userName'],
        profilePicture: json['profilePicture'],
        forumThreadId: json['forumThreadId'],
        forumThread: json['forumThread'],
        userId: json['userId'],
        user: json['user']);
  }
}

//////////////////////////////////////
/// CommentBox
/////////////////////////////////////
// ignore: must_be_immutable
class RRCommentBox extends StatelessWidget {
  Widget? child;
  dynamic formKey;
  dynamic sendButtonMethod;
  dynamic commentController;
  String? userImage;
  String? labelText;
  String? errorText;
  Widget? sendWidget;
  Color? backgroundColor;
  Color? textColor;
  bool withBorder;
  Widget? header;
  FocusNode? focusNode;
  RRCommentBox(
      {this.child,
      this.header,
      this.sendButtonMethod,
      this.formKey,
      this.commentController,
      this.sendWidget,
      this.userImage,
      this.labelText,
      this.focusNode,
      this.errorText,
      this.withBorder = true,
      this.backgroundColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: child!),
        Divider(
          height: 1,
        ),
        header ?? SizedBox.shrink(),
        ListTile(
          tileColor: backgroundColor,
          title: Form(
            key: formKey,
            child: TextFormField(
              maxLines: 4,
              minLines: 1,
              focusNode: focusNode,
              cursorColor: textColor,
              style: TextStyle(color: textColor),
              controller: commentController,
              decoration: InputDecoration(
                enabledBorder: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor!),
                      ),
                focusedBorder: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor!),
                      ),
                border: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor!),
                      ),
                labelText: labelText,
                focusColor: textColor,
                fillColor: textColor,
                labelStyle: TextStyle(color: textColor),
              ),
              validator: (value) => value!.isEmpty ? errorText : null,
            ),
          ),
          trailing: GestureDetector(
            onTap: sendButtonMethod,
            child: sendWidget,
          ),
        ),
      ],
    );
  }
}

////////////////////////////////////////////////////////////////////////
/// ForumHome
////////////////////////////////////////////////////////////////////////
class forumCard extends StatelessWidget {
  final int forumId;
  final String forumTitle;
  final String createdDate;
  final int userId;

  const forumCard(
      {required this.forumId,
      required this.forumTitle,
      required this.createdDate,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 0, top: 0),
      child: InkWell(
        onTap: () {
          currentForumID = this.forumId;
          currentForumName = this.forumTitle;
          UtilModel.route(() => ForumThreadScreen(), context);
        },
        child: Card(
          color: Color.fromRGBO(57, 57, 57, 100),
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          child: Column(
            children: [
              ListTile(
                contentPadding:
                    EdgeInsets.only(bottom: 10.0, top: 10, left: 20, right: 10),
                title: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    forumTitle,
                    style: TextStyle(
                        letterSpacing: 2.0, color: Colors.white, fontSize: 22),
                  ),
                ),
                subtitle: Text(
                  createdDate.substring(0, 10),
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(171, 255, 79, 1),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                      color: Color.fromRGBO(171, 255, 79, 1),
                      width: 0.4,
                      style: BorderStyle.solid),
                ),
                child: ForumLatestThread(forumId),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////
/// ForumThreadsCards
////////////////////////////////////////////////////////////////////////

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
    final ForumThreadProvider forumThreadProvider = new ForumThreadProvider();
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
                        await forumThreadProvider
                            .deleteForumThread(currentThreadID);
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

/////////////////////////////////
////EditForumCard
/////////////////////////////////

class EditForumCard extends StatelessWidget {
  final int forumId;
  final String forumTitle;
  final String createdDate;
  final int userId;

  const EditForumCard(
      {required this.forumId,
      required this.forumTitle,
      required this.createdDate,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    forumEditTitleController.text = forumTitle;

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
                controller: forumEditTitleController,
                cursorColor: Color.fromRGBO(171, 255, 79, 1),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                  ),
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                )),
          ],
        ),
      ),
    );
  }
}

/////////////////////////////////
////EditForumThreadCard
/////////////////////////////////

class EditForumThreadCard extends StatelessWidget {
  final int forumThreadId;
  final String forumThreadTitle;
  final String forumThreadBody;
  final String createdDate;
  final String imageURL;
  final int userId;

  const EditForumThreadCard(
      {required this.forumThreadId,
      required this.forumThreadTitle,
      required this.forumThreadBody,
      required this.createdDate,
      required this.imageURL,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    forumThreadEditTitleController.text = forumThreadTitle;
    forumThreadEditBodyController.text = forumThreadBody;
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
                controller: forumThreadEditTitleController,
                cursorColor: Color.fromRGBO(171, 255, 79, 1),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                  ),
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                )),
            TextFormField(
                style: TextStyle(color: Colors.white),
                controller: forumThreadEditBodyController,
                cursorColor: Color.fromRGBO(171, 255, 79, 1),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                  ),
                  labelText: 'Content',
                  labelStyle: TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                )),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.add_photo_alternate_outlined),
                          iconSize: 50,
                          color: Color.fromRGBO(171, 255, 79, 1),
                          tooltip: "Add Image",
                          onPressed: () async {
                            await editForumThreadGetFromGallery();
                            Navigator.pop(context);
                            UtilModel.route(
                                () => ForumEditThreadScreen(), context);
                          }),
                      Text(
                        "Add Image",
                        style:
                            TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                      ),
                    ],
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: editForumThreadIsImageWidget(imageURL),
            ),
          ],
        ),
      ),
    );
  }
}

/////////////////////////////////
////EditForumThreadCommentCard
/////////////////////////////////

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
                controller: threadCommentEditBodyController,
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
