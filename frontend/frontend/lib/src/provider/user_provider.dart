import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/helper/JWT/securityHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/Profile/profileModel.dart';
import 'package:frontend/src/models/userProfile_model.dart';
import 'package:frontend/src/screens/Profile/userProfileScreen.dart';
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

  getUserAdminStatus() async {
    SecurityHelper securityHelper = new SecurityHelper();
    String userEmail = user.providerData[0].email!;
    final token = securityHelper.getToken();
    final response = await http.get(
      Uri.parse(
          'https://10.0.2.2:5001/api/Auth/GetAdminStatus?email=$userEmail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    var isAdmin;
    if (response.body == "true") {
      isAdmin = true;
    } else {
      isAdmin = false;
    }
    return isAdmin;
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

httpCall() async {
  var userHttp = new UserProvider();
  UserHelper loggedUser = new UserHelper();
  SecurityHelper securityHelper = new SecurityHelper();
  final user = await userHttp.getUserID();
  final token = securityHelper.getToken();
  final response = await http.get(
    Uri.parse('https://10.0.2.2:5001/api/User/ViewProfile?UserId=$user'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );
  print(response.statusCode);
}

Future<String> SaveAllUserDetails(
    int userID,
    String username,
    String description,
    String Role,
    String Location,
    int level,
    String phoNum) async {
  final user = FirebaseAuth.instance.currentUser!;
  UserHelper loggedUser = new UserHelper();
  SecurityHelper securityHelper = new SecurityHelper();
  final token = securityHelper.getToken();

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
    if (Role == "" ||
        Location == "" ||
        level < 0 ||
        level > 9 ||
        phoNum.length < 8) {
      throw ("Cannot Submit Empty Fields");
    }

    //String roleInt = await getRoleIdEnum(Role);
    String officeLocation = await (getLocationIdEnum(Location));

    final response = await http.put(
      Uri.parse('https://10.0.2.2:5001/api/User/EditProfile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "userId": userID,
        "name": username,
        "phoneNumber": phoNum,
        "userDescription": description,
        "userImage": user.photoURL!,
        "officeLocation": int.parse(officeLocation),
        "employeeLevel": 0,
        "userRoles": 0,
      }),
    );
    if (response.statusCode == 201 ||
        response.statusCode == 200 ||
        response.statusCode == 100) {
      return ("Successfully saved profile data");
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
        return SaveAllUserDetails(
            userID, username, description, Role, Location, level, phoNum);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      throw ("Failed to save profile data error" +
          response.statusCode.toString());
    }
  } catch (Exception) {
    return Exception.toString();
  }
}

Future<ProfileUser> getUserProfileObj(int usersid) async {
  final userID = usersid;
  UserHelper loggedUser = new UserHelper();
  SecurityHelper securityHelper = new SecurityHelper();
  final token = await securityHelper.getToken();
  final oldURI = "https://10.0.2.2:5001/api/User/ViewProfile?UserId=$userID";
  final response = await http.get(
    Uri.parse(oldURI),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  final tempDetails = UserProfileModel.fromJSON(jsonDecode(response.body));
  String number = "0000000000";
  if (tempDetails.phoneNumber != null) {
    number = tempDetails.phoneNumber!;
  }
  print(response.statusCode);
  if (response.statusCode == 401) {
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
      return getUserProfileObj(usersid);
    } else {
      throw new Exception("Error with Authentication");
    }
  }
  // print("The TEST");
  // print(tempDetails.userRoles);
  // print(tempDetails.officeLocation);
  String role = await (getRoleEnum(tempDetails.userRoles));
  String location = await (getLocationEnum(tempDetails.officeLocation));

  // print(role);
  // print(location);
  // print("The TEST END");
  ProfileUser userData = new ProfileUser(
      userId: userID,
      userDescription: tempDetails.description,
      userImage: tempDetails.userImage,
      userEmployeeLvl: tempDetails.empLevel,
      userName: tempDetails.name,
      userNumber: number,
      userOfficeLocation: location,
      userRoles: role);
  return userData;
}

Future<String> getRoleEnum(int roleInt) async {
  try {
    if (roleInt < -1 || roleInt > 10) {
      throw ("Error RoleID is Incorrect");
    }
    UserHelper loggedUser = new UserHelper();
    SecurityHelper securityHelper = new SecurityHelper();
    final token = await securityHelper.getToken();
    final oldURI =
        "https://10.0.2.2:5001/api/Enumerations/GetUserRoleType?UserRole=$roleInt";
    final response = await http.get(
      Uri.parse(oldURI),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
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
        return getRoleEnum(roleInt);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      throw ("Failed to delete, error code" + response.statusCode.toString());
    }
  } catch (Exception) {
    return "ERROR " + Exception.toString();
  }
}

Future<String> getLocationEnum(int officeInt) async {
  try {
    if (officeInt < 0 || officeInt > 9) {
      throw ("Error LocationID is Incorrect");
    }
    UserHelper loggedUser = new UserHelper();
    SecurityHelper securityHelper = new SecurityHelper();
    final token = await securityHelper.getToken();
    final oldURI =
        "https://10.0.2.2:5001/api/Enumerations/GetOfficeName?OfficeLocation=$officeInt";
    final response = await http.get(
      Uri.parse(oldURI),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
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
        return getLocationEnum(officeInt);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      throw ("Failed to delete, error code" + response.statusCode.toString());
    }
  } catch (Exception) {
    return "ERROR " + Exception.toString();
  }
}

Future<String> getRoleIdEnum(String role) async {
  try {
    if (role == "") {
      throw ("Error Role is Incorrect");
    }
    UserHelper loggedUser = new UserHelper();
    SecurityHelper securityHelper = new SecurityHelper();
    final token = await securityHelper.getToken();
    final oldURI =
        "https://10.0.2.2:5001/api/Enumerations/GetUserRoleId?RoleName=$role";
    final response = await http.get(
      Uri.parse(oldURI),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
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
        return getRoleIdEnum(role);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      throw ("Failed to delete, error code" + response.statusCode.toString());
    }
  } catch (Exception) {
    return "ERROR " + Exception.toString();
  }
}

Future<String> getLocationIdEnum(String office) async {
  try {
    if (office == "") {
      throw ("Error LocationID is Incorrect");
    }
    UserHelper loggedUser = new UserHelper();
    SecurityHelper securityHelper = new SecurityHelper();
    final token = await securityHelper.getToken();
    final oldURI =
        "https://10.0.2.2:5001/api/Enumerations/GetOfficeId?OfficeName=$office";
    final response = await http.get(
      Uri.parse(oldURI),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
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
        return getLocationIdEnum(office);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      throw ("Failed to delete, error code" + response.statusCode.toString());
    }
  } catch (Exception) {
    return "ERROR " + Exception.toString();
  }
}
