import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:frontend/src/widgets/Profile/profile_picture_widget.dart';

//Widget used to display information about other chat participant
class ChatParticipantBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _chatParticipantBar();
  }
}

class _chatParticipantBar extends State<ChatParticipantBar> {
  //provider class for getting basic user information
  UtilModel utilModel = UtilModel();
  UserProvider userProvider = UserProvider(FirebaseAuth.instance.currentUser);
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: <Widget>[
              //profile picture container
              Expanded(
                flex: 2,
                child: Container(
                  child: ProfilePicture(20),
                ),
              ),

              Expanded(
                flex: 5,
                child: Container(
                  child: Text(
                    userProvider.getUserDisplayName(),
                    style: TextStyle(
                      color: utilModel.greenColor,
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.video,
                        color: utilModel.greenColor,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.phone,
                        color: utilModel.greenColor,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Divider(color: utilModel.greenColor, thickness: 2),
          ),
        ],
      );
}
