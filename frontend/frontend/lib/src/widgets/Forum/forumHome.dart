import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/forumModel.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';
import 'package:frontend/src/widgets/Forum/forumLatestThread.dart';

class ForumHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
          //Top to bottom View
          padding: EdgeInsets.only(bottom: 70),
          children: <Widget>[
            //Children in the list

            FutureBuilder<List<ForumObj>>(
              future: futureForum,
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
                                bottom: 5.0, top: 10, left: 20, right: 10),
                            title: Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                "No Forums Yet",
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
                        ],
                      ),
                    );
                  } else {
                    List<Widget> cards = [];
                    while (iterate.moveNext()) {
                      cards.add(forumCard(
                          forumId: iterate.current.forumId,
                          forumTitle: iterate.current.forumTitle,
                          createdDate: iterate.current.createdDate,
                          userId: iterate.current.userId));
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

class forumCard extends StatelessWidget {
  final int forumId;
  final String forumTitle;
  final String createdDate;
  final int userId;

  const forumCard(
      {required this.forumId,
      required this.forumTitle,
      required this.createdDate,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 0, top: 0),
      child: InkWell(
        onTap: () {
          //noticeID = this.id;
          //UtilModel.route(() => Notice(), context);
        },
        child: Card(
          color: Color.fromRGBO(57, 57, 57, 100),
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
                title: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    forumTitle,
                    style: TextStyle(
                        letterSpacing: 2.0, color: Colors.white, fontSize: 22),
                  ),
                ),
                subtitle: Text(
                  createdDate.substring(0, 10),
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(171, 255, 79, 230),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                      color: Color.fromRGBO(171, 255, 79, 1),
                      width: 0.4,
                      style: BorderStyle.solid),
                ),
                child: ForumLatestThread(forumId),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
