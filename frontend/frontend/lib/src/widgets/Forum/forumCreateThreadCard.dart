import 'dart:convert';

import 'package:frontend/src/screens/Forum/forumCreateForumScreen.dart';
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
                  controller: forumTitleController,
                  cursorColor: Color.fromRGBO(171, 255, 79, 1),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                    ),
                    labelText: 'Forum Title',
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

Future<String> addNewForumThread(String title) async {
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
        "forumId": 0,
        "forumTitle": title,
        "createdDate": "2021-08-04T11:50:49.398Z",
        "userId": 1
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
