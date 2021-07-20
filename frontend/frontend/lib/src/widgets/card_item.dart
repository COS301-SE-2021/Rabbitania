import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/notice.dart';
//import 'package:frontend/src/screens/notice.dart';
import '../models/noticeboardModel.dart';
import '../screens/noticeboardScreen.dart';

int like = 0;
int dislike = 0;
var id = 0;
Uint8List? base64String;

class NoticeboardCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(padding: EdgeInsets.only(bottom: 70), children: <Widget>[
        FutureBuilder<List<Thread>>(
          future: futureThread,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var iterate = snapshot.data!.iterator;
              List<Widget> cards = [];
              while (iterate.moveNext()) {
                cards.add(CardObj(
                    id: iterate.current.threadId,
                    theThreadTitle: iterate.current.threadTitle,
                    theThreadContent: iterate.current.threadContent,
                    theImageURL: iterate.current.imageUrl));
              }
              return new Column(children: cards);
            } else if (!snapshot.hasData) {
              return Card(
                color: Color.fromRGBO(57, 57, 57, 25),
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                clipBehavior: Clip.antiAlias,
                elevation: 2,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.only(
                          bottom: 10.0, top: 10, left: 20, right: 10),

                      // leading: Icon(
                      //   Icons.announcement_outlined, size: 45,
                      //   color: Color.fromRGBO(171, 255, 79, 1),),
                      title: Container(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "No Notifications Yet",
                          style: TextStyle(
                              letterSpacing: 2.0,
                              color: Colors.white,
                              fontSize: 22),
                        ),
                      ),
                      subtitle: Text(
                        "New Notifications will be posted here",
                        style: TextStyle(color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Image.asset("images/RR2.png"),
                    ),
                  ],
                ),
              );
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

class CardObj extends StatelessWidget {
  final int id;
  final String theThreadTitle;
  final String theThreadContent;
  final String theImageURL;

  const CardObj(
      {required this.id,
      required this.theThreadTitle,
      required this.theThreadContent,
      required this.theImageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8, top: 8),
      child: InkWell(
        onTap: () {
          noticeID = this.id;
          UtilModel.route(() => Notice(), context);
        },
        child: Card(
          color: Color.fromRGBO(57, 57, 57, 25),
          shadowColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          child: Column(
            children: [
              ListTile(
                contentPadding:
                    EdgeInsets.only(bottom: 10.0, top: 10, left: 20, right: 10),
                // leading: Icon(
                //   Icons.announcement_outlined, size: 45,
                //   color: Color.fromRGBO(171, 255, 79, 1),),
                title: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    theThreadTitle,
                    style: TextStyle(
                        letterSpacing: 2.0, color: Colors.white, fontSize: 22),
                  ),
                ),
                subtitle: Text(
                  theThreadContent,
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Image.memory(
                  Base64Decoder().convert(theImageURL),
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
