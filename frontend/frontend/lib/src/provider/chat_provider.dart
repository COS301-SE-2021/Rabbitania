import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Chat/chatHelper.dart';
import 'package:frontend/src/helper/JWT/securityHelper.dart';
import 'package:frontend/src/helper/URL/urlHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatProvider {
  UserHelper loggedUser = new UserHelper();
  SecurityHelper securityHelper = new SecurityHelper();
  URLHelper url = new URLHelper();

  // Variables for the Booking Provider
  var email = FirebaseAuth.instance.currentUser!.providerData[0].email!;

  Future<String> getAgoraID() async {
    final baseURL = await url.getBaseURL();
    final token = await securityHelper.getToken();

    final response = await http.get(
      Uri.parse(baseURL + '/api/Agora/GetAppID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      ChatHelper chatHelper = new ChatHelper();
      var key = dotenv.env['ENC_KEY'];

      var decryptedKey = chatHelper.decryptData(
        response.body,
        key.toString(),
      );

      return decryptedKey;
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'name': await loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return getAgoraID();
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      return "Agora ID was not returned: There was some error with the process.";
    }
  }
}