import 'dart:convert';
import 'package:frontend/src/models/forumModel.dart';
import 'package:frontend/src/screens/Forum/forumEditForumScreen.dart';
import 'package:frontend/src/screens/Forum/forumEditThreadScreen.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';
import 'package:frontend/src/screens/Forum/forumThreadScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String>? futureEditThreadString;

class ForumEditForumThreadCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: <Widget>[
        FutureBuilder<List<ForumThread>>(
          future: futureForumThreads,
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
                controller: forumThreadTitleController,
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
                controller: forumThreadBodyController,
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

Future<String> editForumThread(String title, String body) async {
  try {
    if (title == "") {
      throw ("Cannot Submit Empty Fields");
    }

    final response = await http.put(
      Uri.parse('https://10.0.2.2:5001/api/Forum/EditForumThread'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "forumThreadBody": body,
        "forumThreadId": currentThreadID,
        "forumThreadTitle": title,
        "imageUrl": "image.png"
      }),
    );
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 100) {
      return ("Successfully Edited Forum Thread");
    } else {
      throw ("Failed Edit Forum Thread" + response.statusCode.toString());
    }
  } catch (Exception) {
    return Exception.toString();
  }
}
