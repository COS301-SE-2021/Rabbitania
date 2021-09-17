import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/provider/noticeboard_provider.dart';
import 'package:frontend/src/screens/Noticeboard/noticeSingleScreen.dart';
import 'package:frontend/src/widgets/NavigationBar/navigationbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/widgets/Noticeboard/noticeboardEditCard.dart';

import 'noticeboardScreen.dart';

class NoticeBoardEditThread extends StatefulWidget {
  createState() {
    return _NoticeBoardEditThread();
  }
}

TextEditingController titleControllerNoticeboardEdit =
    new TextEditingController();
TextEditingController contentControllerNoticeboardEdit =
    new TextEditingController();

class _NoticeBoardEditThread extends State<NoticeBoardEditThread> {
  final util = new UtilModel();

  UserHelper userHelper = UserHelper();

  int noticeboardEditId = 0;
  void initState() {
    super.initState();
    userHelper.getUserID().then((value) {
      setState(() {
        this.noticeboardEditId = value;
      });
    });
  }

  void next() {
    UtilModel.route(() => Notice(), context);
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
              if (titleControllerNoticeboardEdit.text != "" &&
                  contentControllerNoticeboardEdit.text != "") {
                futureStringReceived = editNoticeboardThread(
                    titleControllerNoticeboardEdit.text,
                    contentControllerNoticeboardEdit.text,
                    noticeboardEditId);
              }
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
        child: Icon(Icons.edit, color: Color.fromRGBO(33, 33, 33, 1)),
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
            'Edit Notice         ',
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
              child: NoticeboardEditThreadCard(),
            ),
          ],
        ),
      ),
    );
  }
}
