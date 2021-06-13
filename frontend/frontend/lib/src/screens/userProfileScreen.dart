import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  createState() {
    return _profileState();
  }
}

class _profileState extends State<ProfileScreen> {
  Widget build(context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'profile screen',
            style: TextStyle(
              color: Color.fromRGBO(171, 255, 79, 1),
            ),
          ),
        ),
      ),
    );
  }
}
