import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/forum_provider.dart';
import 'package:frontend/src/widgets/Forum/forumThreadCommentsCards.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import 'package:flutter_svg/svg.dart';
import 'forumThreadScreen.dart';

class ForumCommentScreen extends StatefulWidget {
  createState() {
    return _ForumCommentScreen();
  }
}

late Future<List<ThreadComments>> futureThreadComments;

class _ForumCommentScreen extends State<ForumCommentScreen> {
  final util = new UtilModel();

  UserHelper userHelper = UserHelper();
  int threadCommentCreatorId = 0;
  void initState() {
    super.initState();
    userHelper.getUserID().then((value) {
      setState(() {
        this.threadCommentCreatorId = value;
      });
      futureThreadComments = fetchThreadComments(currentThreadID);
    });
  }

  void refresh() {
    UtilModel.route(() => ForumCommentScreen(), context);
    setState(() {});
    print("refresh");
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bnb(context),
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            UtilModel.route(() => ForumThreadScreen(), context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Center(
          child: Text(
            currentForumName.toString(),
            style: TextStyle(
              color: Color.fromRGBO(171, 255, 79, 1),
              fontSize: 25,
            ),
          ),
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  refresh();
                },
                child: Icon(Icons.refresh),
              )),
        ],
      ),
      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      body: Container(
          child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.string(
            util.svg_background,
            fit: BoxFit.contain,
          ),
          InkWell(
            onTap: () =>
                {FocusScope.of(context).unfocus(), commentController.clear()},
            child: RRCommentBox(
              userImage: "",
              child: Card(
                  color: Color.fromRGBO(57, 57, 57, 1),
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  clipBehavior: Clip.antiAlias,
                  elevation: 2,
                  child: ForumThreadCommentsCards()),
              labelText: 'Write a comment...',
              withBorder: false,
              errorText: 'Comment cannot be blank',
              sendButtonMethod: () async {
                print(commentController.text);
                await addNewComment(
                    commentController.text, threadCommentCreatorId);
                commentController.clear();
                FocusScope.of(context).unfocus();
                setState(() {});
                refresh();
              },
              formKey: formKey,
              commentController: commentController,
              backgroundColor: Color.fromRGBO(33, 33, 33, 1),
              textColor: Colors.white,
              sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
            ),
          ),
        ],
      )),
    );
  }
}
