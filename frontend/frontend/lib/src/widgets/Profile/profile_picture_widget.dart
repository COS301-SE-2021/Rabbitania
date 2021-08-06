import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/Testing/mockUser.dart';

class ProfilePicture extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  Widget build(context) => Container(
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 40,
          backgroundImage: NetworkImage(user.photoURL!),
        ),
      );
}
