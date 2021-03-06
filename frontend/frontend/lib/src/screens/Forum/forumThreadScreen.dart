import 'package:flutter/material.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/provider/forum_provider.dart';
import 'package:frontend/src/screens/Forum/forumEditForumScreen.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';
import 'package:frontend/src/screens/Forum/forumThreadSearch.dart';
import 'package:frontend/src/widgets/Forum/forumThreadsCards.dart';
import 'package:frontend/src/widgets/NavigationBar/actionBar.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import 'package:flutter_svg/svg.dart';

import 'forumCreateThreadScreen.dart';

class ForumThreadScreen extends StatefulWidget {
  createState() {
    return _ForumThreadScreen();
  }
}

late List<Widget> cards = [];

class _ForumThreadScreen extends State<ForumThreadScreen> {
  final util = new UtilModel();
  void initState() {
    super.initState();
  }

  void search() {
    UtilModel.route(() => ForumThreadSearch(cards), context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ForumProvider forumThreadProvider = new ForumProvider();
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
                      await forumThreadProvider.deleteForum(currentForumID);
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
                  search();
                },
                child: Icon(Icons.search),
              )),
        ],
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
                padding: EdgeInsets.only(bottom: 30),
                child: ForumThreadsCards()),
          ],
        ),
      ),
    );
  }
}
