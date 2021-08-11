import 'dart:convert';
import 'dart:io';
import 'package:frontend/src/models/forumModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Forum/forumEditThreadScreen.dart';
import 'package:frontend/src/screens/Forum/forumThreadScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' as Io;

import 'package:image_picker/image_picker.dart';

Future<String>? futureEditThreadString;
File? imageFile;
String inputImage = "";
//Uint8List? base64String;
String img64 = "";

class ForumEditForumThreadCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(children: <Widget>[
        FutureBuilder<List<ForumThread>>(
          future: futureForumThreads,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var iterate = snapshot.data!.iterator;
              List<Widget> cards = [];
              while (iterate.moveNext()) {
                if (iterate.current.forumThreadId == currentThreadID) {
                  return EditForumThreadCard(
                      forumThreadId: iterate.current.forumThreadId,
                      forumThreadTitle: iterate.current.forumThreadTitle,
                      forumThreadBody: iterate.current.forumThreadBody,
                      createdDate: iterate.current.createdDate,
                      imageURL: iterate.current.imageURL,
                      userId: iterate.current.userId);
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

class EditForumThreadCard extends StatelessWidget {
  final int forumThreadId;
  final String forumThreadTitle;
  final String forumThreadBody;
  final String createdDate;
  final String imageURL;
  final int userId;

  const EditForumThreadCard(
      {required this.forumThreadId,
      required this.forumThreadTitle,
      required this.forumThreadBody,
      required this.createdDate,
      required this.imageURL,
      required this.userId});

  @override
  Widget build(BuildContext context) {
    forumThreadTitleController.text = forumThreadTitle;
    forumThreadBodyController.text = forumThreadBody;
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
                controller: forumThreadTitleController,
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
                style: TextStyle(color: Colors.white),
                controller: forumThreadBodyController,
                cursorColor: Color.fromRGBO(171, 255, 79, 1),
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(171, 255, 79, 1)),
                  ),
                  labelText: 'Content',
                  labelStyle: TextStyle(color: Color.fromRGBO(171, 255, 79, 1)),
                )),
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
                            await _getFromGallery();
                            UtilModel.route(() => ForumThreadScreen(), context);
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
              child: isImageWidget(imageURL),
            ),
          ],
        ),
      ),
    );
  }
}

Widget isImageWidget(String ImageF) {
  try {
    if (ImageF.isNotEmpty && imageFile == null) {
      inputImage = ImageF;
      //if the image in the DB is not Empty and the current selected file is null display as below
      return Image.memory(
        Base64Decoder().convert(ImageF),
        fit: BoxFit.fill,
      );
    } else {
      return Image.file(
        imageFile!,
        height: 250,
        width: 350,
        fit: BoxFit.cover,
      );
    }
  } catch (Exception) {
    return SizedBox.shrink();
  }
}

Future<String> editForumThread(String title, String body) async {
  try {
    if (title == "") {
      throw ("Cannot Submit Empty Fields");
    }

    if (img64 != "") {
      inputImage = img64;
      print(img64);
    }

    final response = await http.put(
      Uri.parse('https://10.0.2.2:5001/api/Forum/EditForumThread'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "forumThreadBody": body,
        "forumThreadId": currentThreadID,
        "forumThreadTitle": title,
        "imageUrl": inputImage
      }),
    );
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 100) {
      return ("Successfully Edited Forum Thread");
    } else {
      throw ("Failed Edit Forum Thread" + response.statusCode.toString());
    }
  } catch (Exception) {
    return Exception.toString();
  }
}

_getFromGallery() async {
  PickedFile? pickedFile = await ImagePicker().getImage(
    source: ImageSource.gallery,
    maxWidth: 1800,
    maxHeight: 1800,
  );
  if (pickedFile != null) {
    imageFile = File(pickedFile.path);

    final bytes = Io.File(pickedFile.path).readAsBytesSync();

    img64 = base64Encode(bytes);
    //print(img64.substring(0, 100));
    //base64String = Base64Decoder().convert(img64);
  }
}
