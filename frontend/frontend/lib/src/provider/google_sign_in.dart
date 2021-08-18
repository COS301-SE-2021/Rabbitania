import 'dart:convert';
import 'dart:io';
import 'package:frontend/src/models/google_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
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

    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }

  Future googleLogout() async {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  void sendUser() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    String url = 'http://10.0.2.2:5000/api/';
    //Map map = { "email" : "email" , "password" : "password" };
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    //request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response1 = await request.close();
    String reply = await response1.transform(utf8.decoder).join();
  }
}
