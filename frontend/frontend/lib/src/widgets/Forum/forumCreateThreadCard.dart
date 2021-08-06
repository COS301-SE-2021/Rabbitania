import 'dart:convert';

import 'package:frontend/src/models/forumModel.dart';
import 'package:frontend/src/screens/Forum/forumCreateForumScreen.dart';
import 'package:frontend/src/screens/Forum/forumCreateThreadScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String>? futureStringReceivedThread;

class ForumCreateThreadCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: threadTitleController,
                  cursorColor: Color.fromRGBO(171, 255, 79, 1),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                    ),
                    labelText: 'Thread Title',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                  ),
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: 20,
                  style: TextStyle(color: Colors.white),
                  controller: threadBodyController,
                  cursorColor: Color.fromRGBO(171, 255, 79, 1),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                    ),
                    labelText: 'Thread Description',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

Future<String> addNewForumThread(int currentId, String title, String body) async {
  try {
    if (title == "") {
      throw ("Cannot Submit Empty Fields");
    }
    

    final response = await http.post(
      Uri.parse('https://10.0.2.2:5001/api/Forum/CreateForumThread'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
      "forumThreadId": 0,
      "forumThreadTitle": title,
      "forumThreadBody": body,
      "createdDate": "2021-08-04T13:45:13.091Z",
      "imageUrl": "string",
      "userId": 1,
      "forumId": currentForumID
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return ("Successfully uploaded new Form");
    } else {
      throw ("Failed to create new thread error" +
          response.statusCode.toString());
    }
  } catch (Exception) {
    return ("Error: " + Exception.toString());
  }
}
