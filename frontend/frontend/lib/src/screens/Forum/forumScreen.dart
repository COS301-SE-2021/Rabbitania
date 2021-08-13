import 'package:flutter/material.dart';
import 'package:frontend/src/models/Forum/forumModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/forum_provider.dart';
import 'package:frontend/src/screens/Booking/bookingHomeScreen.dart';
import 'package:frontend/src/screens/Forum/forumCreateForumScreen.dart';
import 'package:frontend/src/screens/Profile/userProfileScreen.dart';
import 'package:frontend/src/widgets/Forum/forumHome.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import 'package:frontend/src/widgets/expandable_button_widget.dart';
import 'package:flutter_svg/svg.dart';

import '../Noticeboard/noticeboardScreen.dart';

class Forum extends StatefulWidget {
  createState() {
    return _Forum();
  }
}

late Future<List<ForumObj>> futureForum;
late Future<List<ForumThread>> futureForumLatestThread;

class _Forum extends State<Forum> {
  final util = new UtilModel();
  void initState() {
    super.initState();
    futureForum = fetchForum();
  }

  void refresh() {
    UtilModel.route(() => Forum(), context);
    setState(() {});
    print("refresh");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        //Floating action button on Scaffold
        onPressed: () {
          //code to execute on button press

          UtilModel.route(() => ForumCreateScreen(), context);
        },
        backgroundColor: Color.fromRGBO(172, 255, 79, 1),
        child: Icon(Icons.add,
            color: Color.fromRGBO(33, 33, 33, 1)), //icon inside button
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
            Container(padding: EdgeInsets.only(bottom: 0), child: ForumHome()),
          ],
        ),
      ),
    );
  }
}
