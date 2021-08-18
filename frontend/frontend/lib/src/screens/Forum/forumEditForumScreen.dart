import 'package:flutter/material.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/forum_provider.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';
import 'package:frontend/src/widgets/Forum/forumEditForumCard.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import 'package:flutter_svg/svg.dart';

class ForumEditForumScreen extends StatefulWidget {
  createState() {
    return _ForumEditForumScreen();
  }
}

TextEditingController forumEditTitleController = new TextEditingController();

class _ForumEditForumScreen extends State<ForumEditForumScreen> {
  final util = new UtilModel();
  final ForumProvider ForumEditProvider = new ForumProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(172, 255, 79, 1),
        //Floating action button on Scaffold
        onPressed: () {
          //code to execute on button press
          showDialog(
            context: context,
            builder: (context) {
              if (forumEditTitleController.text != "") {
                return FutureBuilder<String>(
                  future: ForumEditProvider.editNewForum(
                      forumEditTitleController.text),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return AlertDialog(
                        elevation: 5,
                        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
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
              } else {
                return AlertDialog(
                    elevation: 5,
                    backgroundColor: Color.fromRGBO(33, 33, 33, 1),
                    content: CircularProgressIndicator());
              }
            },
          );
        },
        child: Icon(Icons.edit,
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
            'Edit Forum         ',
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
              child: ForumEditForumCard(),
            ),
          ],
        ),
      ),
    );
  }
}
