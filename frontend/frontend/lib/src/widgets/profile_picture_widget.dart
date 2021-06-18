import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  Widget build(context) => CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 30,
        backgroundImage: NetworkImage(user.photoURL!),
      );
}
