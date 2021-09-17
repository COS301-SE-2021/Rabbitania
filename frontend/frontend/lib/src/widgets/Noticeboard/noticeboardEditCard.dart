import 'dart:io';
import 'package:frontend/src/models/Noticeboard/noticeboardModel.dart';
import 'package:frontend/src/screens/Noticeboard/noticeSingleScreen.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

File? noticeboardEditImageFile;
String noticeboardEditInputImage = "";
String noticeboardEditImg64 = "";
Future<String>? futureStringReceived;

class NoticeboardEditThreadCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: <Widget>[
        FutureBuilder<List<Thread>>(
          future: futureThread,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var iterate = snapshot.data!.iterator;
              List<Widget> cards = [];
              while (iterate.moveNext()) {
                if (iterate.current.threadId == noticeID) {
                  return NoticeboardEditCard(
                      id: iterate.current.threadId,
                      theThreadTitle: iterate.current.threadTitle,
                      theThreadContent: iterate.current.threadContent,
                      theThreadImageFile: iterate.current.imageUrl);
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
