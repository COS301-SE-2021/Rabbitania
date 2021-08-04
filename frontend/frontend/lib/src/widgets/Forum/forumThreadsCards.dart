import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/forumModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Forum/forumThreadScreen.dart';
import 'package:frontend/src/widgets/Forum/forumLatestThread.dart';

class ForumThreadsCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
          //Top to bottom View
          padding: EdgeInsets.only(bottom: 70),
          children: <Widget>[
            //Children in the list

            FutureBuilder<List<ForumThread>>(
              future: futureForumThreads,
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
                                "No Threads Currently In " + currentForumName,
                                style: TextStyle(
                                    letterSpacing: 2.0,
                                    color: Colors.white,
                                    fontSize: 22),
                              ),
                            ),
                            subtitle: Text(
                              "New Threads will be posted here",
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
                      cards.add(forumThreadCard(
                          forumThreadId: iterate.current.forumThreadId,
                          forumThreadTitle: iterate.current.forumThreadTitle,
                          forumThreadBody: iterate.current.forumThreadBody,
                          createdDate: iterate.current.createdDate,
                          imageURL: iterate.current.imageURL,
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

class forumThreadCard extends StatelessWidget {
  final int forumThreadId;
  final String forumThreadTitle;
  final String forumThreadBody;
  final String createdDate;
  final String imageURL;
  final int userId;

  const forumThreadCard(
      {required this.forumThreadId,
      required this.forumThreadTitle,
      required this.forumThreadBody,
      required this.createdDate,
      required this.imageURL,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 0, top: 0),
      child: InkWell(
        onTap: () {
          // currentForumID = this.forumId;
          // currentForumName = this.forumTitle;
          // UtilModel.route(() => ForumThreadScreen(), context);
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
                leading: FlutterLogo(size: 50),
                title: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    forumThreadTitle,
                    style: TextStyle(
                        letterSpacing: 2.0, color: Colors.white, fontSize: 22),
                  ),
                ),
                subtitle: Text(
                  forumThreadBody,
                  style: TextStyle(color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
