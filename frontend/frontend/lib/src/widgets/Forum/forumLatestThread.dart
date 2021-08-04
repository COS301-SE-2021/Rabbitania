import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/forumModel.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';

Widget ForumLatestThread(int forumIdentifier) {
  futureForumLatestThread = fetchForumThreads(forumIdentifier);

  return Center(
    child: Column(
      children: [
        FutureBuilder<List<ForumThread>>(
          future: futureForumLatestThread,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length == 0) {
                return SizedBox.shrink();
              } else {
                return Container(
                  padding: EdgeInsets.only(bottom: 8, top: 8),
                  child: InkWell(
                    onTap: () {
                      //noticeID = this.id;
                      //UtilModel.route(() => Notice(), context);
                    },
                    child: Card(
                      color: Colors.transparent,
                      shadowColor: Colors.transparent,
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
                                snapshot.data!.last.forumThreadTitle,
                                maxLines: 2,
                                style: TextStyle(
                                    letterSpacing: 2.0,
                                    color: Colors.white,
                                    fontSize: 22),
                              ),
                            ),

                            subtitle: Text(
                              snapshot.data!.last.forumThreadBody,
                              style: TextStyle(color: Colors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Container(
                          //   padding: EdgeInsets.only(top: 5),
                          //   child: Image.memory(
                          //     Base64Decoder().convert(theImageURL),
                          //     fit: BoxFit.fill,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
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
      ],
    ),
  );
}
