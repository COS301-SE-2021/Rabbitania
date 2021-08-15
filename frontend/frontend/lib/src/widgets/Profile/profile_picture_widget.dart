import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final double radius;
  ProfilePicture(this.radius);
  final user = FirebaseAuth.instance.currentUser!;
  Widget build(context) => Container(
        padding: EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: this.radius,
          backgroundImage: NetworkImage(user.photoURL!),
        ),
        width: MediaQuery.of(context).size.width * 0.20,
        height: MediaQuery.of(context).size.width * 0.20,
      );
}
