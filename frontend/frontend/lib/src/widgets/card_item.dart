import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var list = [
  {"userId": 420,"threadId": 7,"threadTitle": "Stage 4 Wave 3 Level 3","threadContent": "https://news24/lockdownnews","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
  {"userId": 6969,"threadId": 6,"threadTitle": "Only max 40 people","threadContent": "New restrictions are making offices and workplaces limited to 40 people","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
  {"userId": 567,"threadId": 5,"threadTitle": "Party Cancelled","threadContent": "Sadly we are going to have to cancel the party this friday. Someone at the office has covid","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
  {"userId": 777,"threadId": 4,"threadTitle": "Party","threadContent": "Party this friday, free pizza for only 40 Rand","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
  {"userId": 1,"threadId": 3,"threadTitle": "New booking system","threadContent": "Please can all employees use the new booking system by monday next week. If you do not do this you wont be able to work","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
  {"userId": 4,"threadId": 2,"threadTitle": "New Restrictions","threadContent": "New covid restrictions","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
  {"userId": 99,"threadId": 1,"threadTitle": "Welcome Back Rabbits (2021)","threadContent": "Lets make this year ours","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },

];

int like = 0;
int dislike = 0;
//
// Future<http.Response> retrieveNoticeboardThreads() {
//   return http.get(Uri.parse('https://localhost:5001/api/NoticeBoard/RetrieveNoticeBoardThreads'));
// }
//
// class Notice {
//   final int threadId;
//   final String threadTitle;
//   final String threadContent;
//   final int minLevel;
//   final String imageUrl;
//   final int permittedUserRoles;
//   final int userId;
//
//   Notice({
//     required this.threadId,
//     required this.threadTitle,
//     required this.threadContent,
//     required this.minLevel,
//     required this.imageUrl,
//     required this.permittedUserRoles,
//     required this.userId,
//   });
//
//   factory Notice.fromJson(Map<String, dynamic> json) {
//     return Notice(
//       threadId: json['threadId'],
//       threadTitle: json['threadTitle'],
//       threadContent: json['threadContent'],
//       minLevel: json['minLevel'],
//       imageUrl: json['imageUrl'],
//       permittedUserRoles: json['permittedUserRoles'],
//       userId: json['userId'],
//     );
//   }
// }
//
// Future<Notice> fetchAlbum() async {
//   final response =
//   await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
//
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Notice.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }






class NoticeboardCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:ListView(
        children: <Widget>[

          for(var item in list)
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
                  ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    leading: Icon(Icons.account_circle_outlined, size: 70, color: Color.fromRGBO(171, 255, 79, 1),),
                    title: Text( item["threadTitle"].toString(),
                      style: TextStyle(letterSpacing: 3.0, color: Colors.white),
                    ),
                    subtitle: Text(item['threadContent'].toString(),
                        style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Image.asset(item["imageUrl"].toString()),
                  ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      // ElevatedButton.icon(
                      //     style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(171, 255, 79, 1)),),
                      //     onPressed: (){},
                      //     icon: Icon(
                      //         Icons.add_comment_outlined,
                      //         color: Color.fromRGBO(0, 0, 0, 1),
                      //         size: 24.0,
                      //     ),
                      //     label: Text("Comment",
                      //     style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)))
                      // ),
                      IconButton(
                        icon: const Icon(
                          Icons.thumb_up_sharp,
                          color: Color.fromRGBO(171, 255, 79, 1),
                          size: 24.0,
                        ),
                        tooltip: 'Up',
                        onPressed: () {

                        },
                      ),
                      Text(like.toString()),
                      IconButton(
                        icon: const Icon(
                          Icons.thumb_down_sharp,
                          color: Color.fromRGBO(171, 255, 79, 1),
                          size: 24.0,
                        ),
                        tooltip: 'Down',
                        onPressed: () {

                        },
                      ),
                      Text(dislike.toString()),
                    ],
                  ),
                ],
              ),
          ),
        ]
      ),
    );
  }
}



// {'Title':"Covid 21","Body":"No more work for 2021"},
// {'Title':"Returning","Body":"Work is Not stopping"},
// {'Title':"Party Time","Body":"This is a message to all employees"}