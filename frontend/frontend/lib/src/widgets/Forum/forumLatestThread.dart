import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/forumModel.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';

Widget ForumLatestThread(int forumIdentifier) {
  futureForumThread = fetchForumThreads(forumIdentifier);

  return Center(
    child: Column(
      children: [
        FutureBuilder<List<ForumThread>>(
          future: futureForumThread,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text("BABABOOEY");
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return CircularProgressIndicator(
                color: Color.fromRGBO(171, 255, 79, 1),
              );
            }
          },
        ),
      ],
    ),
  );
}
