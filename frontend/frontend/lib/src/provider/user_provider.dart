import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/helper/JWT/securityHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/userProfile_model.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final user = FirebaseAuth.instance.currentUser!;
  UserProvider();
  getUserID() async {
    SecurityHelper securityHelper = new SecurityHelper();
    String userEmail = user.providerData[0].email!;
    final token = securityHelper.getToken();
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
    SecurityHelper securityHelper = new SecurityHelper();
    UserHelper loggedUser = new UserHelper();
    final token = securityHelper.getToken();
    final oldURI = "https://10.0.2.2:5001/api/User/ViewProfile?UserId=$user";
    final response = await http.get(
      Uri.parse(oldURI),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final UserDetails = UserProfileModel.fromJSON(jsonDecode(response.body));
      return UserDetails;
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse('https://10.0.2.2:5001/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return getUserProfile();
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      throw Exception("Error with user profile");
    }
  }
}

// Future<List<UserProfileModel>> fetchUserProfiles() async {
//   HttpClient client = new HttpClient();
  
// }
