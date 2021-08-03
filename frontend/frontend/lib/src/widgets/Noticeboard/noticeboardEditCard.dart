import 'dart:convert';
import 'dart:io';
import 'package:frontend/src/models/noticeboardModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Noticeboard/noticeSingleScreen.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardEditThread.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as Io;

File? imageFile;
String inputImage = "";
//Uint8List? base64String;
String img64 = "";
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
    titleController.text = theThreadTitle;
    contentController.text = theThreadContent;
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
                controller: titleController,
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
              controller: contentController,
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
                            await _getFromGallery();
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
              child: isImageWidget(theThreadImageFile),
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

Future<String> addNewThread(String title, String content) async {
  try {
    if (title == "" || content == "") {
      throw ("Cannot Submit Empty Fields");
    }

    if (img64 != "") {
      inputImage = img64;
      print(img64);
    }

    final response = await http.put(
      Uri.parse('https://10.0.2.2:5001/api/NoticeBoard/EditNoticeBoardThread'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'threadId': 5,
        'threadTitle': title,
        'threadContent': content,
        'minLevel': 0,
        'imageUrl': inputImage,
        'permittedUserRoles': 0,
        'userId': 1
      }),
    );
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 100) {
      return ("Successfully uploaded new notice");
    } else {
      throw ("Failed to create new thread error" +
          response.statusCode.toString());
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
