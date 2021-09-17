import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/Noticeboard/noticeboardModel.dart';
import '../../screens/Noticeboard/noticeboardScreen.dart';

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
              if (snapshot.data!.length == 0) {
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
              } else {
                List<Widget> cards = [];
                while (iterate.moveNext()) {
                  cards.add(NoticeboardHomeCard(
                      id: iterate.current.threadId,
                      theThreadTitle: iterate.current.threadTitle,
                      theThreadContent: iterate.current.threadContent,
                      theImageURL: iterate.current.imageUrl));
                }
                return new Column(children: cards);
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return CircularProgressIndicator(
                color: Color.fromRGBO(171, 255, 79, 1),
              );
            }
          },
        ),
      ]),
    );
  }
}
