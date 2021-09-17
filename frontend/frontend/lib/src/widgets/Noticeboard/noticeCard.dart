import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/screens/Noticeboard/noticeSingleScreen.dart';
import '../../models/Noticeboard/noticeboardModel.dart';
import '../../screens/Noticeboard/noticeboardScreen.dart';

class NoticeCard extends StatelessWidget {
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
                if (iterate.current.threadId == noticeID) {
                  cards.add(SingleNoticeCardObj(
                      id: iterate.current.threadId,
                      theThreadTitle: iterate.current.threadTitle,
                      theThreadContent: iterate.current.threadContent,
                      imageFile: iterate.current.imageUrl,
                      icon1: iterate.current.icon1,
                      icon2: iterate.current.icon2,
                      icon3: iterate.current.icon3,
                      icon4: iterate.current.icon4));
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
