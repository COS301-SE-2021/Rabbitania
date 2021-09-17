import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class Test extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  Widget build(context) => Container(
        child: Scaffold(
          appBar: AppBar(
            title: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
          ),
          floatingActionButton: ElevatedButton.icon(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogout();
            },
            icon: FaIcon(FontAwesomeIcons.leaf),
            label: Text('logout'),
          ),
          body: ElevatedButton.icon(
            icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
            label: Text('login with google'),
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogin();
            },
          ),
        ),
      );
}
