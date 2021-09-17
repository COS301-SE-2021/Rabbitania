import 'dart:io';
import 'package:frontend/src/helper/Forum/forumHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/screens/Forum/forumCreateThreadScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

File? forumCreateImageFile;
String forumCreateImg64 = "";
final utilModel = UtilModel();

class ForumCreateThreadCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
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
                    controller: forumThreadTitleController,
                    cursorColor: Color.fromRGBO(171, 255, 79, 1),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                      ),
                      labelText: 'Thread Title',
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                    ),
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: 20,
                    style: TextStyle(color: Colors.white),
                    controller: forumThreadBodyController,
                    cursorColor: Color.fromRGBO(171, 255, 79, 1),
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                      ),
                      labelText: 'Thread Description',
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
                                  await forumCreateGetFromGallery();
                                  UtilModel.route(
                                      () => ForumCreateThreadScreen(), context);
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
                    child: forumCreateIsImageWidget(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String forumCreateInputImage = utilModel.defaultImage;
