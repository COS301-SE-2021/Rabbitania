import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/Noticeboard/noticeboardModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/noticeboard_provider.dart';
import 'package:frontend/src/screens/Profile/userProfileScreen.dart';
import 'package:frontend/src/widgets/NavigationBar/actionBar.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import '../../widgets/Noticeboard/noticeboardHome.dart';
import 'package:flutter_svg/svg.dart';

import 'noticeboardCreateThread.dart';

class NoticeBoard extends StatefulWidget {
  createState() {
    return _NoticeBoard();
  }
}

late Future<List<Thread>> futureThread;
late Future<bool> deleteResponse;

class _NoticeBoard extends State<NoticeBoard> {
  final util = new UtilModel();
  UserHelper userHelper = UserHelper();
  void initState() {
    super.initState();
    futureThread = fetchNotice();
    // deleteResponse = deleteThread(-1);
  }

  void refresh() {
    setState(() {});
  }

  void next() {
    UtilModel.route(() => ProfileScreen(), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        //Floating action button on Scaffold
        onPressed: () {
          UtilModel.route(() => NoticeBoardThread(), context);
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
        title: Center(
          child: Text(
            'Noticeboard      ',
            style: TextStyle(
              color: Color.fromRGBO(171, 255, 79, 1),
              fontSize: 35,
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
              padding: EdgeInsets.only(bottom: 0),
              child: NoticeboardCard(),
            ),
          ],
        ),
      ),
    );
  }
}
