import 'package:flutter/material.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/provider/forum_provider.dart';
import 'package:frontend/src/screens/Forum/forumThreadScreen.dart';
import 'package:frontend/src/widgets/Forum/forumEditForumThreadCard.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import 'package:flutter_svg/svg.dart';

class ForumEditThreadScreen extends StatefulWidget {
  createState() {
    return _ForumEditThreadScreen();
  }
}

TextEditingController forumThreadEditTitleController =
    new TextEditingController();
TextEditingController forumThreadEditBodyController =
    new TextEditingController();

class _ForumEditThreadScreen extends State<ForumEditThreadScreen> {
  final util = new UtilModel();
  final ForumThreadProvider forumEditThreadProvider = new ForumThreadProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(172, 255, 79, 1),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              if (forumThreadEditTitleController.text != "") {
                return FutureBuilder<String>(
                  future: forumEditThreadProvider.editForumThread(
                      forumThreadEditTitleController.text,
                      forumThreadEditBodyController.text),
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
                              UtilModel.route(
                                  () => ForumThreadScreen(), context);
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
        child: Icon(Icons.edit, color: Color.fromRGBO(33, 33, 33, 1)),
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
            'Edit Forum Thread        ',
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
              util.svgBackground,
              fit: BoxFit.contain,
            ),
            Container(
              child: ForumEditForumThreadCard(),
            ),
          ],
        ),
      ),
    );
  }
}
