
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
                    controller: titleController,
                  ),
                  TextFormField(
                    controller: contentController,
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
                          return addNewThread(titleController.text,contentController.text);
                        },
                      );
                    },
                    child: Icon(Icons.control_point),
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }
}




class Thread {
  final int userId;
  final String threadTitle;
  final String threadContent;
  final int minLevel;
  final String imageUrl;
  final int permittedUserRoles;

  Thread({
    required this.userId,
    required this.threadTitle,
    required this.threadContent,
    required this.minLevel,
    required this.imageUrl,
    required this.permittedUserRoles,

  });

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      userId: json['userId'],
      threadTitle: json['threadTitle'],
      threadContent: json['threadContent'],
      minLevel: json['minLevel'],
      imageUrl: json['imageUrl'],
      permittedUserRoles: json['permittedUserRoles'],

    );
  }
}


Widget addNewThread(String title, String content)
{
  try{
    if(title==""||content=="")
      {
        throw("Cannot Submit Empty fields");
      }
    else{
      //createAlbum(title);
      connectAndGet(title,content);

      // ignore: unrelated_type_equality_checks
      if(true)
        {
          return AlertDialog(
            content: Text("Successfully Uploaded New Thread"),
          );
        }
      else
        {
          throw("When submitting the request an error occurred");
        }
    }
  }
  catch(Exception)
  {
    return AlertDialog(
      content: Text(Exception.toString()),
    );
  }
}



// Future<void> makePostRequest() async {
//   final url = Uri.parse('https://jsonplaceholder.typicode.com');
//   final headers = {"Content-type": "application/json"};
//   //Map<String, dynamic> jsonObj = {'userId': 1,'threadTitle': "title",'threadContent': "content",'minLevel': 0,'imageUrl': "string",'permittedUserRoles': 0};
//   final json = '{"title": "Hello", "body": "body text", "userId": 1}';
//   final response = await post(url, headers: headers, body: json);
//   print('Status code: ${response.statusCode}');
//   print('Body: ${response.body}');
// }



Future<bool> connectAndGet(String title, String content) async {
  try {
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    String url = 'http://10.0.2.2:5000/api/NoticeBoard/AddNoticeBoardThread';
    Map<String, dynamic> jsonObj = {'userId': 1,'threadTitle': "title",'threadContent': "content",'minLevel': 0,'imageUrl': "string",'permittedUserRoles': 0};//tested this is a json object when json.encode is run on it


    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    //request.headers.add("body", json.encode(jsonObj));
    request.add(utf8.encode(json.encode(jsonObj)));


    HttpClientResponse response1 = await request.close();
    print(response1.statusCode);
    print(response1.first);

    return true;
  }
  catch(Exception)
  {
    print(Exception);
    return false;
  }

}

Future<Thread> createAlbum(String title) async {
  HttpClient client = new HttpClient();
  client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

  final response = await http.post(
    Uri.parse('http://10.0.2.2:5000/api/NoticeBoard/AddNoticeBoardThread'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'userId': 1,
      'threadTitle': "title",
      'threadContent': "content",
      'minLevel': 0,
      'imageUrl': "string",
      'permittedUserRoles': 0
    }),
  );


  print(response.body);
  //print(jsonDecode(response.body));
  print(response.statusCode);

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Thread.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
