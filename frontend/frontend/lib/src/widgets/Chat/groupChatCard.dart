import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/src/models/util_model.dart';

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
    return Row(children: [
      Container(
        child: SizedBox(
          height: 85.0,
          width: 85.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(72),
            child: decodeBase64(this.avatar),
          ),
        ),
      ),
      Text(this.roomName, style: TextStyle(color: utilModel.greenColor)),
    ]);
  }
}
