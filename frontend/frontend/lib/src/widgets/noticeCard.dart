import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/notice.dart';
import '../models/noticeboardModel.dart';
import '../screens/noticeboardScreen.dart';

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
                  cards.add(singleCardObj(
                      id: iterate.current.threadId,
                      theThreadTitle: iterate.current.threadTitle,
                      theThreadContent: iterate.current.threadContent,
                      theImageURL: iterate.current.imageUrl));
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

class singleCardObj extends StatelessWidget {
  final int id;
  final String theThreadTitle;
  final String theThreadContent;
  final String theImageURL;

  const singleCardObj(
      {required this.id,
      required this.theThreadTitle,
      required this.theThreadContent,
      required this.theImageURL});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Color.fromRGBO(57, 57, 57, 1),
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        clipBehavior: Clip.antiAlias,
        elevation: 2,
        child: Column(
          children: [
            Container(
              child: Image.asset(theImageURL),
            ),
            ListTile(
              contentPadding:
                  EdgeInsets.only(bottom: 10.0, top: 10, left: 20, right: 10),
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
              ),
              trailing: IconButton(
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
                        titleTextStyle:
                            TextStyle(color: Colors.white, fontSize: 32),
                        title: Text("Delete Notice"),
                        contentTextStyle:
                            TextStyle(color: Colors.white, fontSize: 16),
                        content: Text(
                            "Are you sure you want to delete this notice?"),
                        actions: [
                          IconButton(
                            icon: const Icon(
                              Icons.check,
                              color: Color.fromRGBO(171, 255, 79, 1),
                              size: 24.0,
                            ),
                            tooltip: 'Delete',
                            onPressed: () async {
                              final deleteResponse =
                                  await deleteThread(this.id);
                              UtilModel.route(() => NoticeBoard(), context);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: Color.fromRGBO(255, 79, 79, 1),
                              size: 24.0,
                            ),
                            tooltip: 'Cancel',
                            onPressed: () {
                              //final deleteResponse = await deleteThread(this.id);
                              UtilModel.route(() => NoticeBoard(), context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
