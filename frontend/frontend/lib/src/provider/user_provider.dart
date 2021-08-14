import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/models/userProfile_model.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final user = FirebaseAuth.instance.currentUser!;
  UserProvider();
  getUserID() async {
    String userEmail = user.providerData[0].email!;
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
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
