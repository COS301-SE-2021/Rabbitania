import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/forum_provider.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';
import 'package:frontend/src/widgets/Forum/forumCreateForumCard.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import 'package:flutter_svg/svg.dart';

class ForumCreateScreen extends StatefulWidget {
  createState() {
    return _ForumCreateScreen();
  }
}

final forumCreateTitleController = TextEditingController();

class _ForumCreateScreen extends State<ForumCreateScreen> {
  final util = new UtilModel();

  UserHelper userHelper = UserHelper();

  int forumCreatorId = 0;
  void initState() {
    super.initState();
    userHelper.getUserID().then((value) {
      setState(() {
        this.forumCreatorId = value;
      });
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(172, 255, 79, 1),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              futureStringReceivedForum =
                  addNewForum(forumCreateTitleController.text, forumCreatorId);
              return FutureBuilder<String>(
                future: futureStringReceivedForum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
            color: Color.fromRGBO(33, 33, 33, 1)), //icon inside button
      ),
      bottomNavigationBar: bnb(context),
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            UtilModel.route(() => Forum(), context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'Create Forum         ',
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
              child: ForumCreateCard(),
            ),
          ],
        ),
      ),
    );
  }
}
