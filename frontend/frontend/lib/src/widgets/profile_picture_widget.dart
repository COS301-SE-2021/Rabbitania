import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  Widget build(context) => Container(
        padding: const EdgeInsets.all(10.0),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 30,
                backgroundImage: NetworkImage(user.photoURL!),
              ),
              Text(user.email!,
                  maxLines: 2,
                  style: TextStyle(
                    height: 1.5,
                    color: Color.fromRGBO(171, 255, 79, 1),
                  )),
            ],
          ),
        ),
      );
}
