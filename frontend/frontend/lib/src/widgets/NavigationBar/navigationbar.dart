import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/userProfile_model.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:frontend/src/screens/Booking/bookingHomeScreen.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardScreen.dart';
import 'package:frontend/src/screens/Profile/userProfileScreen.dart';

var userInfoProfile;
var userRoleProfile;
var userOfficeProfile;
var userLevelProfile;

fab(BuildContext context) {
  return FloatingActionButton(
    key: Key('NoticePage'),
    //Floating action button on Scaffold
    onPressed: () {
      //code to execute on button press
    },
    child: Icon(Icons.send), //icon inside button
  );
}

fabl(BuildContext context) {
  return FloatingActionButtonLocation.endDocked;
}

Widget bnb(BuildContext context) {
  return BottomAppBar(
    //bottom navigation bar on scaffold
    color: Color.fromRGBO(171, 255, 79, 1),
    //shape: CircularNotchedRectangle(), //shape of notch
    //notchMargin: 10, //notche margin between floating button and bottom appbar
    child: Row(
      //children inside bottom appbar
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.home,
            color: Color.fromRGBO(33, 33, 33, 1),
          ),
          onPressed: () {
            UtilModel.route(() => NoticeBoard(), context);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.forum_sharp,
            color: Color.fromRGBO(33, 33, 33, 1),
          ),
          onPressed: () {
            UtilModel.route(() => Forum(), context);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.book_sharp,
            color: Color.fromRGBO(33, 33, 33, 1),
          ),
          onPressed: () {
            UtilModel.route(() => BookingScreen(), context);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.message_sharp,
            color: Color.fromRGBO(33, 33, 33, 1),
          ),
          onPressed: () {
            UtilModel.route(() => NoticeBoard(), context);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.person,
            color: Color.fromRGBO(33, 33, 33, 1),
          ),
          onPressed: () async {
            var userProfile = new UserProvider();
            userInfoProfile = await userProfile.getUserProfile();
            userRoleProfile = userInfoProfile.userRole;
            userOfficeProfile = userInfoProfile.office;
            userLevelProfile = userInfoProfile.userRole;
            UtilModel.route(() => ProfileScreen(), context);
          },
        ),
      ],
    ),
  );
}
