import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/provider/forum_provider.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';

class ForumHome extends StatelessWidget {
  ForumProvider ForumHomeProvider = new ForumProvider();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
          //Top to bottom View
          padding: EdgeInsets.only(bottom: 70),
          children: <Widget>[
            //Children in the list

            FutureBuilder<List<ForumObj>>(
              future: ForumHomeProvider.fetchForum(),
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
                              "New Forums will be posted here",
                              style: TextStyle(color: Colors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    cards = [];
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
                  return Align();
                }
              },
            ),
          ]),
    );
  }
}
