import 'package:flutter/material.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/widgets/Profile/profile_picture_widget.dart';

class ChatUsersCard extends StatelessWidget {
  //TODO:make avatar the profile picture instead of first two letters
  final utilModel = UtilModel();
  final String displayName;
  final String displayImage;
  ChatUsersCard({required this.displayName, required this.displayImage});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        //profile picture of the user
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
          child: CircleAvatar(
            //backgroundColor: utilModel.greenColor,
            backgroundImage: NetworkImage(displayImage),
            radius: 35,
          ),
        ),
        Text(displayName, style: TextStyle(fontSize: 35, color: Colors.white)),
      ],
    );
  }
}
