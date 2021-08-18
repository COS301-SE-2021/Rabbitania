import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/forum_provider.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';
import 'package:frontend/src/screens/Forum/forumThreadScreen.dart';
import 'package:frontend/src/widgets/Forum/forumCreateForumCard.dart';
import 'package:frontend/src/widgets/Forum/forumCreateThreadCard.dart';
import 'package:frontend/src/widgets/Forum/forumEditForumThreadCard.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import 'package:frontend/src/widgets/Noticeboard/noticeboardCreateCard.dart';
import 'package:flutter_svg/svg.dart';

class ForumCreateThreadScreen extends StatefulWidget {
  createState() {
    return _ForumCreateThreadScreen();
  }
}

final forumThreadTitleController = TextEditingController();
final forumThreadBodyController = TextEditingController();

class _ForumCreateThreadScreen extends State<ForumCreateThreadScreen> {
  final util = new UtilModel();
  UserHelper userHelper = UserHelper();

  int ForumThreadCreatorId = 0;
  void initState() {
    super.initState();
    userHelper.getUserID().then((value) {
      setState(() {
        this.ForumThreadCreatorId = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ForumThreadProvider ForumCreateThreadProvider = new ForumThreadProvider();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(172, 255, 79, 1),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return FutureBuilder<String>(
                future: ForumCreateThreadProvider.addNewForumThreadNLP(
                    currentForumID,
                    forumThreadTitleController.text,
                    forumThreadBodyController.text,
                    ForumThreadCreatorId),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data! != "true") {
                    return AlertDialog(
                      elevation: 5,
                      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
                      content: Text(snapshot.data!),
                      titleTextStyle:
                          TextStyle(color: Colors.white, fontSize: 32),
                      title: Text(snapshot.data!),
                      contentTextStyle:
                          TextStyle(color: Colors.white, fontSize: 16),
                      actions: [
                        IconButton(
                          icon: const Icon(
                            Icons.check,
                            color: Color.fromRGBO(171, 255, 79, 1),
                            size: 24.0,
                          ),
                          tooltip: 'Continue',
                          onPressed: () async {
                            forumThreadTitleController.text = "";
                            forumThreadBodyController.text = "";
                            ForumCreateImg64 = "";
                            UtilModel.route(() => Forum(), context);
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasData && snapshot.data! == "true") {
                    return AlertDialog(
                      elevation: 5,
                      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
                      content: Text(
                          "It is possible that a similar forum thread already exists, are you sure you want to continue"),
                      titleTextStyle:
                          TextStyle(color: Colors.white, fontSize: 32),
                      title: Text("A similar forum thread has been detected"),
                      contentTextStyle:
                          TextStyle(color: Colors.white, fontSize: 16),
                      actions: [
                        IconButton(
                          icon: const Icon(
                            Icons.check,
                            color: Color.fromRGBO(171, 255, 79, 1),
                            size: 24.0,
                          ),
                          tooltip: 'Continue',
                          onPressed: () async {
                            ForumCreateThreadProvider.addNewForumThread(
                                currentForumID,
                                forumThreadTitleController.text,
                                forumThreadBodyController.text,
                                ForumThreadCreatorId);

                            forumThreadTitleController.text = "";
                            forumThreadBodyController.text = "";
                            ForumCreateImg64 = "";
                            UtilModel.route(() => Forum(), context);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 24.0,
                          ),
                          tooltip: 'Cancel',
                          onPressed: () async {
                            forumThreadTitleController.text = "";
                            forumThreadBodyController.text = "";
                            ForumCreateImg64 = "";
                            UtilModel.route(() => Forum(), context);
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return AlertDialog(
                        elevation: 5,
                        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
                        content: Text('${snapshot.error}'));
                  }
                  return AlertDialog(
                      elevation: 5,
                      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
                      content: CircularProgressIndicator());
                },
              );
            },
          );
        },
        child: Icon(Icons.add,
            color: Color.fromRGBO(33, 33, 33, 1)), //icon inside ),
      ),
      bottomNavigationBar: bnb(context),
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            UtilModel.route(() => ForumThreadScreen(), context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'Create Forum Thread         ',
            style: TextStyle(
              color: Color.fromRGBO(171, 255, 79, 1),
              fontSize: 25,
            ),
          ),
        ),
        actions: [],
      ),
      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      body: Center(
        child: Stack(
          children: <Widget>[
            SvgPicture.string(
              util.svg_background,
              fit: BoxFit.contain,
            ),
            Container(
              child: ForumCreateThreadCard(),
            ),
          ],
        ),
      ),
    );
  }
}
