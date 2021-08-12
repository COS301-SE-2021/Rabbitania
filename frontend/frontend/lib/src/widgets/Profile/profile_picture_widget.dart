import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/Testing/mockUser.dart';

class ProfilePicture extends StatelessWidget {
  final double radius;
  ProfilePicture(this.radius);
  final user = FirebaseAuth.instance.currentUser!;
  Widget build(context) => Container(
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: this.radius,
          backgroundImage: NetworkImage(user.photoURL!),
        ),
      );
}
