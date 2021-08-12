import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String>? futureEditString;

class ForumEditForumCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: <Widget>[
        FutureBuilder<List<ForumObj>>(
          future: futureForum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var iterate = snapshot.data!.iterator;
              List<Widget> cards = [];
              while (iterate.moveNext()) {
                if (iterate.current.forumId == currentForumID) {
                  return EditForumCard(
                      forumId: iterate.current.forumId,
                      forumTitle: iterate.current.forumTitle,
                      createdDate: iterate.current.createdDate,
                      userId: iterate.current.userId);
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
