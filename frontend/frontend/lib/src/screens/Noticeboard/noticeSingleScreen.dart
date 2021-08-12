import 'package:flutter/material.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/noticeboard_provider.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardEditThread.dart';
import 'package:frontend/src/screens/Profile/userProfileScreen.dart';
import 'package:frontend/src/widgets/NavigationBar/actionBar.dart';
import 'package:frontend/src/widgets/Noticeboard/noticeboardEditCard.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import 'package:frontend/src/widgets/Noticeboard/noticeCard.dart';
import 'package:flutter_svg/svg.dart';
import 'noticeboardScreen.dart';

class Notice extends StatefulWidget {
  createState() {
    return _Notice();
  }
}

var noticeID = -1; //get changed eveytime a new notice is tapped

class _Notice extends State<Notice> {
  final util = new UtilModel();

  void next() {
    UtilModel.route(() => ProfileScreen(), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FancyFab(
        numberOfItems: 2,
        icon1: Icons.edit,
        onPressed1: () {
          titleControllerNoticeboardEdit.clear();
          contentControllerNoticeboardEdit.clear();
          noticeboardEditImageFile = null;
          UtilModel.route(() => NoticeBoardEditThread(), context);
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
                title: Text("Delete Notice"),
                contentTextStyle: TextStyle(color: Colors.white, fontSize: 16),
                content: Text("Are you sure you want to delete this notice?"),
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
                      final deleteResponse = await deleteThread(noticeID);
                      UtilModel.route(() => NoticeBoard(), context);
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
                      UtilModel.route(() => NoticeBoard(), context);
                    },
                  ),
                ],
              );
            },
          );
        },
        icon3: Icons.airplane_ticket,
        onPressed3: () {
          print("Fab 3");
        },
      ),
      bottomNavigationBar: bnb(context),
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            UtilModel.route(() => NoticeBoard(), context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'Notice         ',
            style: TextStyle(
              color: Color.fromRGBO(171, 255, 79, 1),
              fontSize: 25,
            ),
          ),
        ),
        actions: [],
      ),

      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      //bottomNavigationBar: navigationBar(),
      body: Center(
        child: Stack(
          children: <Widget>[
            SvgPicture.string(
              util.svg_background,
              fit: BoxFit.contain,
            ),
            Container(
              child: NoticeCard(),
            ),
          ],
        ),
      ),
    );
  }
}
