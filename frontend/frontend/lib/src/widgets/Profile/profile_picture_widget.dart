import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final double radius;
  final user = FirebaseAuth.instance.currentUser!;
  String displayImage = '';
  ProfilePicture(this.radius, {altDisplayImage = ''}) {
    if (altDisplayImage != '') {
      this.displayImage = altDisplayImage;
    } else {
      this.displayImage = user.photoURL!;
    }
  }

  Widget build(context) => CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: this.radius,
        backgroundImage: NetworkImage(this.displayImage),
      );
}
