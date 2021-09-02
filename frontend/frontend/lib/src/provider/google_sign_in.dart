import 'dart:convert';
import 'dart:io';
import 'package:frontend/src/models/google_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = GoogleSignIn();
final firebaseAuth = FirebaseAuth.instance;

class GoogleSignInProvider extends ChangeNotifier {
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print('IdToken: ${googleAuth.idToken}');
    print('accessToken: ${googleAuth.accessToken}');
    await firebaseAuth.signInWithCredential(credential);
    notifyListeners();
  }

  Future googleLogout() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
    notifyListeners();
  }
}
