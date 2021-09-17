import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/provider/forum_provider.dart';
import 'package:frontend/src/screens/Forum/forumCommentScreen.dart';

Widget ForumLatestThread(int forumIdentifier) {
  final utilModel = UtilModel();
  ForumThreadProvider forumLatestThreadProvider = new ForumThreadProvider();

  return Center(
    child: Column(
      children: [
        FutureBuilder<List<ForumThread>>(
          future: forumLatestThreadProvider.fetchForumThreads(forumIdentifier),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length == 0) {
                return SizedBox.shrink();
              } else {
                return Container(
                  padding: EdgeInsets.only(bottom: 8, top: 8),
                  child: InkWell(
                    onTap: () {
                      currentThreadID = snapshot.data!.first.forumThreadId;
                      currentThreadName = snapshot.data!.first.forumThreadTitle;
                      currentThreadBody = snapshot.data!.first.forumThreadBody;
                      currentThreadImage = snapshot.data!.first.imageURL;
                      UtilModel.route(() => ForumCommentScreen(), context);
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
                            title: Container(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                snapshot.data!.first.forumThreadTitle,
                                maxLines: 2,
                                style: TextStyle(
                                    letterSpacing: 2.0,
                                    color: utilModel.greyColor,
                                    fontSize: 22),
                              ),
                            ),
                            subtitle: Text(
                              snapshot.data!.first.forumThreadBody,
                              style: TextStyle(color: utilModel.greyColor),
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
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return Align();
            }
          },
        ),
      ],
    ),
  );
}
