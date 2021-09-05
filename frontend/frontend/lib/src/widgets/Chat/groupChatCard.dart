import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/screens/Chat/GroupChatRoomScreen.dart';

class GroupChatCard extends StatelessWidget {
  final utilModel = UtilModel();
  final String avatar;
  final String roomName;
  GroupChatCard({required this.avatar, required this.roomName});

  //function to convert base 64 to image file
  decodeBase64(String base64Image) {
    return Image.memory(
      Base64Decoder().convert(base64Image),
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupChatRoomScreen(roomName),
          ),
        );
      },
      child: Row(children: [
        SizedBox(width: 30.0),
        Container(
          child: SizedBox(
            height: 60.0,
            width: 60.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(72),
              child: decodeBase64(this.avatar),
            ),
          ),
        ),
        SizedBox(width: 30.0),
        Text(
          this.roomName,
          style: TextStyle(
            color: utilModel.whiteColor,
            fontSize: 25,
          ),
          maxLines: 2,
        ),
      ]),
    );
  }
}
