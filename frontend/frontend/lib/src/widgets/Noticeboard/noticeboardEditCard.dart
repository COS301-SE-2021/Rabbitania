import 'dart:io';
import 'package:frontend/src/helper/Noticeboard/noticeboardHelper.dart';
import 'package:frontend/src/models/Noticeboard/noticeboardModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Noticeboard/noticeSingleScreen.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardEditThread.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

File? noticeboardEditImageFile;
String noticeboardEditInputImage = "";
//Uint8List? base64String;
String noticeboardEditImg64 = "";
Future<String>? futureStringReceived;

class NoticeboardEditThreadCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: <Widget>[
        FutureBuilder<List<Thread>>(
          future: futureThread,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var iterate = snapshot.data!.iterator;
              List<Widget> cards = [];
              while (iterate.moveNext()) {
                if (iterate.current.threadId == noticeID) {
                  return EditCard(
                      id: iterate.current.threadId,
                      theThreadTitle: iterate.current.threadTitle,
                      theThreadContent: iterate.current.threadContent,
                      theThreadImageFile: iterate.current.imageUrl);
                }
              }
              return new Column(children: cards);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator(
              color: Color.fromRGBO(171, 255, 79, 1),
            );
          },
        ),
      ]),
    );
  }
}

class EditCard extends StatelessWidget {
  final int id;
  final String theThreadTitle;
  final String theThreadContent;
  final String theThreadImageFile;

  const EditCard(
      {required this.id,
      required this.theThreadTitle,
      required this.theThreadContent,
      required this.theThreadImageFile});

  @override
  Widget build(BuildContext context) {
    titleControllerNoticeboardEdit.text = theThreadTitle;
    contentControllerNoticeboardEdit.text = theThreadContent;
    return Container(
      padding: EdgeInsets.all(16),
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        child: Column(
          children: [
            TextFormField(
                style: TextStyle(color: Colors.white),
                controller: titleControllerNoticeboardEdit,
                cursorColor: Color.fromRGBO(171, 255, 79, 1),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                  ),
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                )),
            TextFormField(
              minLines: 1,
              maxLines: 20,
              style: TextStyle(color: Colors.white),
              controller: contentControllerNoticeboardEdit,
              cursorColor: Color.fromRGBO(171, 255, 79, 1),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                ),
                labelText: 'Content',
                labelStyle: TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          icon: const Icon(Icons.add_photo_alternate_outlined),
                          iconSize: 50,
                          color: Color.fromRGBO(171, 255, 79, 1),
                          tooltip: "Add Image",
                          onPressed: () async {
                            await noticeboardEditGetFromGallery();
                            UtilModel.route(
                                () => NoticeBoardEditThread(), context);
                          }),
                      Text(
                        "Add Image",
                        style:
                            TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                      ),
                    ],
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: noticeboardEditIsImageWidget(theThreadImageFile),
            ),
          ],
        ),
      ),
    );
  }
}
