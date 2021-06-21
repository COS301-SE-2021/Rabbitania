import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/userProfile_model.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final user = FirebaseAuth.instance.currentUser!;

  getUserID() async {
    String userEmail = user.email!;
    final response = await http.get(
      Uri.parse(
          'https://10.0.2.2:5001/api/GoogleSignIn/GetID?email=$userEmail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return int.parse(response.body);
  }

  Future<UserProfileModel> getUserProfile() async {
    final user = await getUserID();

    final response = await http.get(
      Uri.parse('https://10.0.2.2:5001/api/User/ViewProfile?UserId=$user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final UserDetails = UserProfileModel.fromJSON(jsonDecode(response.body));
    return UserDetails;
  }
}
