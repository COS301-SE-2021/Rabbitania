import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/forumModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Forum/forumCommentScreen.dart';
import 'package:frontend/src/screens/Forum/forumThreadScreen.dart';
import 'package:frontend/src/widgets/Forum/forumLatestThread.dart';

class ForumThreadCommentsCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        //Children in the list

        FutureBuilder<List<ThreadComments>>(
      future: futureThreadComments,
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
                        "No Comments",
                        style: TextStyle(
                            letterSpacing: 2.0,
                            color: Colors.white,
                            fontSize: 22),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            List<Widget> cards = [];
            while (iterate.moveNext()) {
              cards.add(forumCommentCard(
                  threadCommentId: iterate.current.threadCommentId,
                  commentBody: iterate.current.commentBody,
                  createdDate: iterate.current.createdDate,
                  imageURL: iterate.current.imageURL,
                  likes: iterate.current.likes,
                  dislikes: iterate.current.dislikes,
                  forumThreadId: iterate.current.forumThreadId,
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
    );
  }
}

class forumCommentCard extends StatelessWidget {
  final int threadCommentId;
  final String commentBody;
  final String createdDate;
  final String imageURL;
  final int likes;
  final int dislikes;
  final int forumThreadId;
  final int userId;

  const forumCommentCard({
    required this.threadCommentId,
    required this.commentBody,
    required this.createdDate,
    required this.imageURL,
    required this.likes,
    required this.dislikes,
    required this.forumThreadId,
    required this.userId,
  });

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
                    commentBody,
                    style: TextStyle(
                        letterSpacing: 2.0, color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
