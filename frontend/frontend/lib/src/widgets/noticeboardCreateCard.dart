
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../screens/noticeboardCreateThread.dart';

var titleInput = "";
var contextInput = "";

class NoticeboardThreadCard extends StatelessWidget {
  Future<String>? futureStringReceived;

  @override
  Widget build(BuildContext context) {
    return Center(
      child:ListView(
          children: <Widget>[
            Card(
              color: Color.fromRGBO(57, 57, 57, 25),
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
              ),
              clipBehavior: Clip.antiAlias,
              elevation: 10,
              child: Column(
                children: [
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: titleController,
                    cursorColor: Color.fromRGBO(171, 255, 79, 1),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                      ),
                      labelText: 'Enter the title of your notice thread',
                      labelStyle: TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),

                    ),
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: contentController,
                    cursorColor: Color.fromRGBO(171, 255, 79, 1),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                      ),
                      labelText: 'Enter the content',
                      labelStyle: TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),

                    ),
                  ),
                  TextButton(
                    // When the user presses the button, show an alert dialog containing
                    // the text that the user has entered into the text field.
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          titleInput = titleController.text;
                          contextInput = contentController.text;
                          futureStringReceived = addNewThread(titleController.text,contentController.text);
                          return FutureBuilder<String>(
                            future: futureStringReceived,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return AlertDialog(content: Text(snapshot.data!));
                              } else if (snapshot.hasError) {
                                return AlertDialog(content: Text('${snapshot.error}'));
                              }
                              return AlertDialog(content: CircularProgressIndicator());
                            },
                          );
                        },
                      );
                    },
                    child: Icon(Icons.control_point, color:Color.fromRGBO(171, 255, 79, 1) ,),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }
}


Future<String> addNewThread(String title,String content) async {
  try {
    if (title == "" || content == "") {
      throw("Cannot Submit Empty fields");
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
        'imageUrl': "string",
        'permittedUserRoles': 0
      }),
    );

    if (response.statusCode == 201||response.statusCode == 200) {
      return ("Successfully uploaded new thread");
    } else {
      throw("Failed to create new thread error" +
          response.statusCode.toString());
    }
  } catch(Exception)
  {
    return Exception.toString();
  }
}

