import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/noticeboardModel.dart';
import '../screens/noticeboardScreen.dart';

// var list = [
//   {"userId": 420,"threadId": 7,"threadTitle": "Stage 4 Wave 3 Level 3","threadContent": "https://news24/lockdownnews","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
//   {"userId": 6969,"threadId": 6,"threadTitle": "Only max 40 people","threadContent": "New restrictions are making offices and workplaces limited to 40 people","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
//   {"userId": 567,"threadId": 5,"threadTitle": "Party Cancelled","threadContent": "Sadly we are going to have to cancel the party this friday. Someone at the office has covid","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
//   {"userId": 777,"threadId": 4,"threadTitle": "Party","threadContent": "Party this friday, free pizza for only 40 Rand","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
//   {"userId": 1,"threadId": 3,"threadTitle": "New booking system","threadContent": "Please can all employees use the new booking system by monday next week. If you do not do this you wont be able to work","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
//   {"userId": 4,"threadId": 2,"threadTitle": "New Restrictions","threadContent": "New covid restrictions","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
//   {"userId": 99,"threadId": 1,"threadTitle": "Welcome Back Rabbits (2021)","threadContent": "Lets make this year ours","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
//
// ];

int like = 0;
int dislike = 0;


// List<dynamic> threads = [
//   {"userId": 420,"threadId": 7,"threadTitle": "Stage 4 Wave 3 Level 3","threadContent": "https://news24/lockdownnews","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
//   {"userId": 6969,"threadId": 6,"threadTitle": "Only max 40 people","threadContent": "New restrictions are making offices and workplaces limited to 40 people","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
//   {"userId": 567,"threadId": 5,"threadTitle": "Party Cancelled","threadContent": "Sadly we are going to have to cancel the party this friday. Someone at the office has covid","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
//   {"userId": 777,"threadId": 4,"threadTitle": "Party","threadContent": "Party this friday, free pizza for only 40 Rand","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
//   {"userId": 1,"threadId": 3,"threadTitle": "New booking system","threadContent": "Please can all employees use the new booking system by monday next week. If you do not do this you wont be able to work","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
//   {"userId": 4,"threadId": 2,"threadTitle": "New Restrictions","threadContent": "New covid restrictions","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
//   {"userId": 99,"threadId": 1,"threadTitle": "Welcome Back Rabbits (2021)","threadContent": "Lets make this year ours","minLevel": 0,"imageUrl": "images/TestImage1.png","permittedUserRoles": 0 },
// ];

class NoticeboardCard extends StatelessWidget {

  Widget cancelButton = IconButton(
    icon: const Icon(
      Icons.close,
      color: Color.fromRGBO(255, 79, 79, 1),
      size: 24.0,
    ),
    tooltip: 'Cancel',
    onPressed:  () {},
  );
  Widget continueButton = IconButton(
    icon: const Icon(
      Icons.check,
      color: Color.fromRGBO(171, 255, 79, 1),
      size: 24.0,
    ),
    tooltip: 'Delete',
    onPressed:  () {},
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child:ListView(
        children: <Widget>[
            FutureBuilder<List<Thread>>(
              future: futureThread,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var iter = snapshot.data!.iterator;

                  List<Widget> cards = [];
                  while (iter.moveNext()) {

                    cards.add(Card(
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
                            leading: Icon(
                              Icons.announcement_outlined, size: 45,
                              color: Color.fromRGBO(171, 255, 79, 1),),
                            title: Text(iter.current.threadTitle,
                              style: TextStyle(letterSpacing: 3.0, color: Colors
                                  .white),
                            ),
                            subtitle: Text(iter.current.threadContent,
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing:
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete_forever_sharp,
                                      color: Color.fromRGBO(171, 255, 79, 1),
                                      size: 24.0,
                                    ),
                                    tooltip: 'Delete',
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            elevation: 5,
                                            backgroundColor: Color.fromRGBO(33, 33, 33, 1),
                                            titleTextStyle: TextStyle(color: Colors.white, fontSize: 32),
                                            title: Text("Delete Thread"),
                                            contentTextStyle: TextStyle(color: Colors.white, fontSize: 16) ,
                                            content: Text("Are you sure you want to delete this thread?"),
                                            actions: [
                                              continueButton,
                                              cancelButton,
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),

                            ),

                          Image.asset(iter.current.imageUrl),
                        ],
                      ),
                    ),
                    );
                  }

                  return new Column(children: cards);

                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            )
        ]
      ),
    );
  }
}
