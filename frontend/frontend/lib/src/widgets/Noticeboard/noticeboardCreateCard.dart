import 'dart:io';
import 'package:frontend/src/helper/Noticeboard/noticeboardHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../screens/Noticeboard/noticeboardCreateThread.dart';

File? noticeboardCreateImageFile;
String noticeboardCreateImg64 = "";
Future<String>? futureStringReceived;
final utilModel = UtilModel();

class NoticeboardThreadCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            clipBehavior: Clip.antiAlias,
            elevation: 0,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: titleControllerNoticeboardCreate,
                  cursorColor: Color.fromRGBO(171, 255, 79, 1),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                    ),
                    labelText: 'Title',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                  ),
                ),
                TextFormField(
                  minLines: 1,
                  maxLines: 20,
                  style: TextStyle(color: Colors.white),
                  controller: contentControllerNoticeboardCreate,
                  cursorColor: Color.fromRGBO(171, 255, 79, 1),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                    ),
                    labelText: 'Content',
                    labelStyle:
                        TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
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
                              icon: const Icon(
                                  Icons.add_photo_alternate_outlined),
                              iconSize: 50,
                              color: Color.fromRGBO(171, 255, 79, 1),
                              tooltip: "Add Image",
                              onPressed: () async {
                                await noticeboardCreateGetFromGallery();
                                UtilModel.route(
                                    () => NoticeBoardThread(), context);
                              }),
                          Text(
                            "Add Image",
                            style: TextStyle(
                                color: Color.fromRGBO(171, 255, 79, 1)),
                          ),
                        ],
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child:
                      noticeboardCreateImageWidget(noticeboardCreateImageFile),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

String noticeboardCreateInputImage = utilModel.defaultImage;
