import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/helper/JWT/securityHelper.dart';
import 'package:frontend/src/models/userProfile_model.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final user = FirebaseAuth.instance.currentUser!;
  UserProvider();
  getUserID() async {
    SecurityHelper securityHelper = new SecurityHelper();
    String userEmail = user.providerData[0].email!;
    var token = securityHelper.getToken();
    final response = await http.get(
      Uri.parse('https://10.0.2.2:5001/api/Auth/GetID?email=$userEmail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    return int.parse(response.body);
  }

  Future<UserProfileModel> getUserProfile() async {
    final user = await getUserID();
    final oldURI = "https://10.0.2.2:5001/api/User/ViewProfile?UserId=$user";
    final response = await http.get(
      Uri.parse(oldURI),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final UserDetails = UserProfileModel.fromJSON(jsonDecode(response.body));
    return UserDetails;
  }
}

// Future<List<UserProfileModel>> fetchUserProfiles() async {
//   HttpClient client = new HttpClient();
  
// }
