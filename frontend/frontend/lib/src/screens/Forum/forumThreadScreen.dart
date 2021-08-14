import 'package:flutter/material.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/forum_provider.dart';
import 'package:frontend/src/screens/Forum/forumEditForumScreen.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';
import 'package:frontend/src/widgets/Forum/forumThreadsCards.dart';
import 'package:frontend/src/widgets/NavigationBar/actionBar.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import 'package:frontend/src/widgets/expandable_button_widget.dart';
import 'package:flutter_svg/svg.dart';

import 'forumCreateThreadScreen.dart';

class ForumThreadScreen extends StatefulWidget {
  createState() {
    return _ForumThreadScreen();
  }
}

late Future<List<ForumThread>> futureForumThreads;

class _ForumThreadScreen extends State<ForumThreadScreen> {
  final util = new UtilModel();
  void initState() {
    super.initState();
    futureForumThreads = fetchForumThreads(currentForumID);
  }

  void refresh() {
    UtilModel.route(() => ForumThreadScreen(), context);
    setState(() {});
    print("refresh");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FancyFab(
        heroTag: "ForumThreadPage",
        numberOfItems: 3,
        icon1: Icons.add,
        onPressed1: () {
          UtilModel.route(() => ForumCreateThreadScreen(), context);
        },
        icon2: Icons.delete,
        onPressed2: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                elevation: 5,
                backgroundColor: Color.fromRGBO(33, 33, 33, 1),
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 32),
                title: Text("Delete Forum"),
                contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
                content: Text("Are you sure you want to delete this Forum?"),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.check,
                      color: Color.fromRGBO(171, 255, 79, 1),
                      size: 24.0,
                    ),
                    tooltip: 'Delete',
                    onPressed: () async {
                      // ignore: unused_local_variable
                      final deleteResponse = await deleteForum(currentForumID);
                      UtilModel.route(() => Forum(), context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color.fromRGBO(255, 79, 79, 1),
                      size: 24.0,
                    ),
                    tooltip: 'Cancel',
                    onPressed: () {
                      //final deleteResponse = await deleteThread(this.id);
                      UtilModel.route(() => Forum(), context);
                    },
                  ),
                ],
              );
            },
          );
        },
        icon3: Icons.edit,
        onPressed3: () {
          //print(currentForumID);
          UtilModel.route(() => ForumEditForumScreen(), context);
        },
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
      body: Center(
        child: Stack(
          //HERE is the stack for the forum page, the stack fills back to front (last child will be on the top of the stack)
          children: <Widget>[
            // Children of type widget
            SvgPicture.string(
              util.svg_background,
              fit: BoxFit.contain,
            ),
            Container(
                padding: EdgeInsets.only(bottom: 30),
                child: ForumThreadsCards()),
          ],
        ),
      ),
    );
  }
}
