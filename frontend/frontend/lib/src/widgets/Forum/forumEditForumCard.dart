import 'dart:convert';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/screens/Forum/forumEditForumScreen.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String>? futureEditString;

class ForumEditForumCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: <Widget>[
        FutureBuilder<List<ForumObj>>(
          future: futureForum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var iterate = snapshot.data!.iterator;
              List<Widget> cards = [];
              while (iterate.moveNext()) {
                if (iterate.current.forumId == currentForumID) {
                  return EditForumCard(
                      forumId: iterate.current.forumId,
                      forumTitle: iterate.current.forumTitle,
                      createdDate: iterate.current.createdDate,
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
                controller: forumTitleController,
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

Future<String> editNewForum(String title) async {
  try {
    if (title == "") {
      throw ("Cannot Submit Empty Fields");
    }

    final response = await http.put(
      Uri.parse('https://10.0.2.2:5001/api/Forum/EditForum'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{"forumId": currentForumID, "forumTitle": title}),
    );
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 100) {
      return ("Successfully uploaded new notice");
    } else {
      throw ("Failed to create new thread error" +
          response.statusCode.toString());
    }
  } catch (Exception) {
    return Exception.toString();
  }
}
