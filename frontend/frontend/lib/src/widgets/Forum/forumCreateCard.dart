import 'dart:convert';

import 'package:frontend/src/screens/Forum/forumCreateScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String>? futureStringReceived;

class ForumCreateCard extends StatelessWidget {
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
                TextFormField(
                  minLines: 1,
                  maxLines: 20,
                  style: TextStyle(color: Colors.white),
                  controller: forumContentController,
                  cursorColor: Color.fromRGBO(171, 255, 79, 1),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                    ),
                    labelText: 'Forum Content',
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

Future<String> addNewThread(String title, String content) async {
  try {
    if (title == "" || content == "") {
      throw ("Cannot Submit Empty Fields");
    }

    final response = await http.post(
      Uri.parse('https://10.0.2.2:5001/api/NoticeBoard/AddNoticeBoardThread'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': 1,
        'threadTitle': title,
        'threadContent': content,
        'minLevel': 0,
        'permittedUserRoles': 0
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return ("Successfully uploaded new notice");
    } else {
      throw ("Failed to create new thread error" +
          response.statusCode.toString());
    }
  } catch (Exception) {
    return ("Error: " + Exception.toString());
  }
}
