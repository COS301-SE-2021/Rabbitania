import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/src/models/userProfile_model.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final user = FirebaseAuth.instance.currentUser!;
  UserProvider();
  getUserID() async {
    String userEmail = user.providerData[0].email!;
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

httpCall() async {
  var userHttp = new UserProvider();
  final user = await userHttp.getUserID();

  final response = await http.get(
    Uri.parse('https://10.0.2.2:5001/api/User/ViewProfile?UserId=$user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(response.statusCode);
}

Future<String> SaveAllUserDetails(
    int userID,
    String username,
    String description,
    int Role,
    int Location,
    int level,
    String phoNum) async {
  final user = FirebaseAuth.instance.currentUser!;

  print(userID.toString() +
      " " +
      username +
      " " +
      description +
      " " +
      Role.toString() +
      " " +
      Location.toString() +
      " " +
      level.toString() +
      " " +
      phoNum);

  try {
    if (Role == "" || Location == "" || level < 0 || level > 9 || phoNum == 0) {
      throw ("Cannot Submit Empty Fields");
    }

    final response = await http.put(
      Uri.parse('https://10.0.2.2:5001/api/User/EditProfile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userID,
        "name": username,
        "phoneNumber": phoNum,
        "userDescription": description,
        "userImage": user.photoURL!,
        "officeLocation": Location
      }),
    );
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 100) {
      return ("Successfully uploaded new notice");
    } else {
      throw ("Failed to create new thread error" +
          response.statusCode.toString());
    }
  } catch (Exception) {
    return Exception.toString();
  }
}
