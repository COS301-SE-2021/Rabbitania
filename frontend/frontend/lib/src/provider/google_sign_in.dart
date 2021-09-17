import 'package:frontend/src/helper/JWT/securityHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = GoogleSignIn();
final firebaseAuth = FirebaseAuth.instance;
final securityHelper = SecurityHelper();

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

    await firebaseAuth.signInWithCredential(credential);
    var token = await FirebaseAuth.instance.currentUser!.getIdToken();
    securityHelper.setFirestoreIdToken(token);

    notifyListeners();
  }

  Future googleLogout() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
    notifyListeners();
  }
}
