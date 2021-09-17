import 'package:flutter/material.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/screens/Forum/forumCreateForumScreen.dart';
import 'package:frontend/src/screens/Forum/forumSearch.dart';
import 'package:frontend/src/widgets/Forum/forumHome.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import 'package:flutter_svg/svg.dart';

class Forum extends StatefulWidget {
  createState() {
    return _Forum();
  }
}

late Future<List<ForumThread>> futureForumLatestThread;
late List<Widget> cards = [];

class _Forum extends State<Forum> {
  final util = new UtilModel();
  void initState() {
    super.initState();
  }

  void search() {
    UtilModel.route(() => ForumSearch(cards), context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UtilModel.route(() => ForumCreateScreen(), context);
        },
        backgroundColor: Color.fromRGBO(172, 255, 79, 1),
        child: Icon(Icons.add, color: Color.fromRGBO(33, 33, 33, 1)),
      ),
      bottomNavigationBar: bnb(context),
      appBar: AppBar(
        leading: const BackButton(),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Center(
          child: Text(
            'Forum   ',
            style: TextStyle(
              color: Color.fromRGBO(171, 255, 79, 1),
              fontSize: 35,
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
            Container(padding: EdgeInsets.only(bottom: 0), child: ForumHome()),
          ],
        ),
      ),
    );
  }
}
