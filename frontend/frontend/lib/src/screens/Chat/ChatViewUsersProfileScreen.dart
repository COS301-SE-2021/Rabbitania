import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:frontend/src/widgets/Profile/profile_picture_widget.dart';

class ChatViewUsersProfileScreen extends StatefulWidget {
  final idUser;
  ChatViewUsersProfileScreen({required this.idUser});
  @override
  _ChatViewUsersProfileScreenState createState() =>
      _ChatViewUsersProfileScreenState();
}

class _ChatViewUsersProfileScreenState
    extends State<ChatViewUsersProfileScreen> {
  final utilModel = UtilModel();
  final userProvider = UserProvider();
  final userHelper = UserHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userProvider.getUserProfileFromUserId(widget.idUser),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        List<Widget> children = [];
        if (snapshot.hasData) {
          return SafeArea(
            child: Center(
              child: Scaffold(
                backgroundColor: utilModel.greenColor,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onLongPress: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ProfilePicture(45,
                                    altDisplayImage: snapshot.data.userImage),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, left: 20),
                                  child: Text(
                                    '${snapshot.data.name}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: utilModel.greyColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Container(
                              padding: EdgeInsets.all(15.0),
                              child: Text(snapshot.data.description,
                                  style: TextStyle(
                                      color: utilModel.greyColor,
                                      fontSize: 25)),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: utilModel.greyColor,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(children: [
                                Text(
                                  'Employee level:',
                                  style: TextStyle(
                                      color: utilModel.greenColor,
                                      fontSize: 25),
                                ),
                                Text(
                                  '${snapshot.data.empLevel}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 40),
                                ),
                              ]),
                              //group for empLevel
                              Expanded(
                                flex: 3,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Office location:',
                                        style: TextStyle(
                                            color: utilModel.greenColor,
                                            fontSize: 25),
                                      ),
                                      Text(
                                        '${userHelper.determineOfficePassIn(snapshot.data.empLevel)}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 40),
                                      ),
                                    ]),
                              ),

                              //group for userRoles
                              Expanded(
                                flex: 3,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'User role:',
                                        style: TextStyle(
                                            color: utilModel.greenColor,
                                            fontSize: 25),
                                      ),
                                      Text(
                                        '${userHelper.determineRolePassIn(snapshot.data.userRoles)}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 40),
                                      ),
                                    ]),
                              ),

                              //group for phonenumber
                              Expanded(
                                flex: 3,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Phone number:',
                                        style: TextStyle(
                                            color: utilModel.greenColor,
                                            fontSize: 25),
                                      ),
                                      Text(
                                        '${snapshot.data.phoneNumber.toString()}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 40),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
              child: CircularProgressIndicator(color: utilModel.greenColor));
        }
      },
    );
  }
}
