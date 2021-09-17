import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileDisplay extends StatelessWidget {
  @override
  Widget build(context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Logged in',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          CircleAvatar(
            maxRadius: 40,
          ),
          SizedBox(height: 8),
          Text('Name: ' + user.displayName!,
              style: TextStyle(
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
