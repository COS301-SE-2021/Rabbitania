import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
