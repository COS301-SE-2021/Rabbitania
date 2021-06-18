import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  Widget build(context) => Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            VerticalDivider(),
            Text(user.email!,
                style: TextStyle(
                  color: Color.fromRGBO(171, 255, 79, 1),
                )),
          ],
        ),
      );
}
