import 'package:flutter/material.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/widgets/Chat/chatUsersCard.dart';

class ChatViewUsersScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _chatViewUserScreenState();
}

class _chatViewUserScreenState extends State<ChatViewUsersScreen> {
  final utilModel = UtilModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: utilModel.greyColor,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ChatUsersCard(
                displayName: 'DeVilliers',
                displayImage:
                    'https://i.pinimg.com/originals/08/61/b7/0861b76ad6e3b156c2b9d61feb6af864.jpg',
              ),
              ChatUsersCard(
                displayName: 'Matthew',
                displayImage:
                    'https://i.pinimg.com/originals/08/61/b7/0861b76ad6e3b156c2b9d61feb6af864.jpg',
              ),
              ChatUsersCard(
                displayName: 'Joseph',
                displayImage:
                    'https://i.pinimg.com/originals/08/61/b7/0861b76ad6e3b156c2b9d61feb6af864.jpg',
              ),
              ChatUsersCard(
                displayName: 'James',
                displayImage:
                    'https://i.pinimg.com/originals/08/61/b7/0861b76ad6e3b156c2b9d61feb6af864.jpg',
              ),
              ChatUsersCard(
                displayName: 'Scatt',
                displayImage:
                    'https://i.pinimg.com/originals/08/61/b7/0861b76ad6e3b156c2b9d61feb6af864.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
