import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/helper/Chat/fireStoreHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:frontend/src/screens/Chat/chatViewUsersProfileScreen.dart';
import 'package:frontend/src/widgets/Profile/profile_picture_widget.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

//Widget used to display information about other chat participant
class ChatParticipantBar extends StatefulWidget {
  final idUser;
  ChatParticipantBar(this.idUser);
  @override
  State<StatefulWidget> createState() {
    return ChatParticipantBarState();
  }
}

class ChatParticipantBarState extends State<ChatParticipantBar> {
  UtilModel utilModel = UtilModel();
  UserProvider userProvider = UserProvider();
  final userHelper = UserHelper();
  final fireStoreHelper = FireStoreHelper();
  @override
  Widget build(BuildContext context) => StreamBuilder<Object>(
      stream: fireStoreHelper.getUserById(widget.idUser),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Container(
                  child: Row(
                    children: [
                      InkWell(
                        splashColor: utilModel.greenColor,
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatViewUsersProfileScreen(
                                  idUser: widget.idUser),
                            ),
                          );
                        },
                        child: ProfilePicture(
                          30,
                          altDisplayImage: snapshot.data.docs[0]['avatar'],
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        snapshot.data.docs[0]['displayName'],
                        style: TextStyle(
                          color: utilModel.greenColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: FutureBuilder(
                      future:
                          userProvider.getUserProfileFromUserId(widget.idUser),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return IconButton(
                            icon: Icon(
                              FontAwesomeIcons.phone,
                              color: utilModel.greenColor,
                            ),
                            onPressed: () async {
                              await FlutterPhoneDirectCaller.callNumber(
                                  snapshot.data.phoneNumber);
                            },
                          );
                        }
                        return IconButton(
                          icon: Icon(
                            FontAwesomeIcons.phone,
                            color: utilModel.greyColor,
                          ),
                          onPressed: () {},
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      });
}
