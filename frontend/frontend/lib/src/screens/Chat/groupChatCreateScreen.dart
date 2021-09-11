import 'dart:convert';
import 'dart:developer';
import 'dart:io' as Io;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/helper/Chat/groupChatHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Chat/GroupChatRoomScreen.dart';
import 'package:image_picker/image_picker.dart';

class GroupChatCreateScreen extends StatefulWidget {
  final GroupChatHelper groupChatHelper;
  GroupChatCreateScreen({required this.groupChatHelper});

  @override
  _GroupChatCreateScreenState createState() => _GroupChatCreateScreenState();
}

class _GroupChatCreateScreenState extends State<GroupChatCreateScreen> {
  File? _image;
  final utilModel = UtilModel();
  final userHelper = UserHelper();
  final textController = TextEditingController();
  final firestoreHelper = FireStoreHelper();
  var _imageBase64;
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      final bytes = Io.File(pickedFile.path).readAsBytesSync();
      _imageBase64 = base64Encode(bytes);
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      final bytes = Io.File(pickedFile.path).readAsBytesSync();
      _imageBase64 = base64Encode(bytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: utilModel.greyColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Container(
              child: SizedBox(
                height: 144.0,
                width: 144.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(72),
                  child: () {
                    if (_image != null) {
                      return Image.file(_image!, fit: BoxFit.cover);
                    } else {
                      return CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg'),
                      );
                    }
                  }(),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(FontAwesomeIcons.camera,
                        color: utilModel.greenColor),
                    onPressed: () {
                      _getFromCamera();
                    },
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.image,
                        color: utilModel.greenColor),
                    onPressed: () {
                      _getFromGallery();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  style: TextStyle(
                    color: utilModel.greenColor,
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                  cursorColor: utilModel.greenColor,
                  decoration: InputDecoration(
                    hintText: 'Group title',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 25,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: utilModel.greenColor),
                    ),
                    hoverColor: utilModel.greenColor,
                    focusColor: utilModel.greenColor,
                    labelStyle: TextStyle(
                      color: utilModel.greenColor,
                    ),
                  ),
                  controller: textController,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: utilModel.greenColor),
                  ),
                  child: FutureBuilder(
                    future: userHelper.getUserID(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData) {
                        int myId = snapshot.data;
                        return IconButton(
                          icon: Icon(FontAwesomeIcons.plus,
                              color: utilModel.greenColor),
                          onPressed: () {
                            //TODO: figure out how to save images in firestore
                            //TODO: navigate to new Chat screen
                            if (textController.text != '') {
                              //adds current logged in userID to participants array before creating groupChatroom
                              widget.groupChatHelper.addUserToArray(myId);
                              _imageBase64 == null
                                  ? firestoreHelper.createGroupChatRoom(
                                      textController.text,
                                      widget.groupChatHelper.usersArray,
                                      utilModel.defaultImage)
                                  : firestoreHelper.createGroupChatRoom(
                                      textController.text,
                                      widget.groupChatHelper.usersArray,
                                      _imageBase64);
                              print(widget.groupChatHelper.usersArray);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      GroupChatRoomScreen(textController.text),
                                ),
                              );
                            }
                          },
                        );
                      }
                      return CircularProgressIndicator(
                          color: utilModel.greenColor);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
