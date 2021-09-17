import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/provider/noticeboard_provider.dart';
import 'package:frontend/src/screens/Profile/userProfileScreen.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import 'package:frontend/src/widgets/Noticeboard/noticeboardCreateCard.dart';
import 'package:flutter_svg/svg.dart';
import 'noticeboardScreen.dart';

class NoticeBoardThread extends StatefulWidget {
  createState() {
    return _NoticeThreadBoard();
  }
}

final titleControllerNoticeboardCreate = TextEditingController();
final contentControllerNoticeboardCreate = TextEditingController();

class _NoticeThreadBoard extends State<NoticeBoardThread> {
  final utilModel = new UtilModel();
  UserHelper userHelper = UserHelper();

  int noticeboardCreatorId = 0;
  void initState() {
    super.initState();
    userHelper.getUserID().then((value) {
      setState(() {
        this.noticeboardCreatorId = value;
      });
    });
  }

  void next() {
    UtilModel.route(() => ProfileScreen(), context);
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
              futureStringReceived = addNewThread(
                  titleControllerNoticeboardCreate.text,
                  contentControllerNoticeboardCreate.text,
                  noticeboardCreatorId);
              return FutureBuilder<String>(
                future: futureStringReceived,
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
                            UtilModel.route(() => NoticeBoard(), context);
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
        child: Icon(Icons.add, color: Color.fromRGBO(33, 33, 33, 1)),
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
            'Create Notice         ',
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
              utilModel.svgBackground,
              fit: BoxFit.contain,
            ),
            Container(
              child: NoticeboardThreadCard(),
            ),
          ],
        ),
      ),
    );
  }
}
