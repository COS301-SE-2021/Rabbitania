import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:frontend/src/screens/Booking/bookingHomeScreen.dart';
import 'package:frontend/src/screens/Chat/chatViewUsersScreen.dart';
import 'package:frontend/src/screens/Forum/forumScreen.dart';
import 'package:frontend/src/screens/Noticeboard/noticeboardScreen.dart';
import 'package:frontend/src/screens/Profile/userProfileScreen.dart';

fab(BuildContext context) {
  return FloatingActionButton(
    key: Key('NoticePage'),
    onPressed: () {},
    child: Icon(Icons.send),
  );
}

fabl(BuildContext context) {
  return FloatingActionButtonLocation.endDocked;
}

Widget bnb(BuildContext context) {
  return BottomAppBar(
    color: Color.fromRGBO(171, 255, 79, 1),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          onPressed: () {
            UtilModel.route(() => NoticeBoard(), context);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.home,
                color: Color.fromRGBO(33, 33, 33, 1),
              ),
              Text(
                'Home',
                style: TextStyle(
                  color: Color.fromRGBO(33, 33, 33, 1),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            UtilModel.route(() => Forum(), context);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.forum_sharp,
                color: Color.fromRGBO(33, 33, 33, 1),
              ),
              Text(
                'Forum',
                style: TextStyle(
                  color: Color.fromRGBO(33, 33, 33, 1),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            UtilModel.route(() => BookingScreen(), context);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.book_sharp,
                color: Color.fromRGBO(33, 33, 33, 1),
              ),
              Text(
                'Bookings',
                style: TextStyle(
                  color: Color.fromRGBO(33, 33, 33, 1),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            UtilModel.route(() => ChatViewUsersScreen(), context);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FaIcon(
                FontAwesomeIcons.solidComments,
                color: Color.fromRGBO(33, 33, 33, 1),
              ),
              Text(
                'Chats',
                style: TextStyle(
                  color: Color.fromRGBO(33, 33, 33, 1),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            UtilModel.route(() => ProfileScreen(), context);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.account_circle,
                color: Color.fromRGBO(33, 33, 33, 1),
              ),
              Text(
                'Profile',
                style: TextStyle(
                  color: Color.fromRGBO(33, 33, 33, 1),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
