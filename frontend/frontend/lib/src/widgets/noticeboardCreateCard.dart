import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            Container(
            padding: EdgeInsets.all(16),
            child: Card(
              color: Colors.transparent,
              //shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)
              ),
              clipBehavior: Clip.antiAlias,
              elevation: 0,
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
                      labelText: 'Title',
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
                      labelText: 'Content',
                      labelStyle: TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromRGBO(171, 255, 79, 1)),
                    ),
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
                    child: Text("Create", style: TextStyle(color: Colors.black)),
                    //child: Icon(Icons.control_point, color:Color.fromRGBO(171, 255, 79, 1) , size: 50,),
                  ),
                ],
              ),
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
      throw("Cannot Submit Empty Fields");
    }
    final response = await http.post(
      Uri.parse('https://10.0.2.2:5001/api/NoticeBoard/AddNoticeBoardThread'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': 2,
        'threadTitle': title,
        'threadContent': content,
        'minLevel': 0,
        'imageUrl': "images/RR.png",
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

