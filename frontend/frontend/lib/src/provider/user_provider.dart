import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/Profile/profileModel.dart';
import 'package:frontend/src/models/userProfile_model.dart';
import 'package:frontend/src/screens/Profile/userProfileScreen.dart';
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
    String Role,
    String Location,
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

  final oldURI = "https://10.0.2.2:5001/api/User/ViewProfile?UserId=$userID";
  final response = await http.get(
    Uri.parse(oldURI),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  final tempDetails = UserProfileModel.fromJSON(jsonDecode(response.body));
  String number = "0000000000";
  if (tempDetails.phoneNumber != null) {
    number = tempDetails.phoneNumber!;
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
    final oldURI =
        "https://10.0.2.2:5001/api/Enumerations/GetUserRoleType?UserRole=$roleInt";
    final response = await http.get(
      Uri.parse(oldURI),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
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
    final oldURI =
        "https://10.0.2.2:5001/api/Enumerations/GetOfficeName?OfficeLocation=$officeInt";
    final response = await http.get(
      Uri.parse(oldURI),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
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
    final oldURI =
        "https://10.0.2.2:5001/api/Enumerations/GetUserRoleId?RoleName=$role";
    final response = await http.get(
      Uri.parse(oldURI),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
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
    final oldURI =
        "https://10.0.2.2:5001/api/Enumerations/GetOfficeId?OfficeName=$office";
    final response = await http.get(
      Uri.parse(oldURI),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
    } else {
      throw ("Failed to delete, error code" + response.statusCode.toString());
    }
  } catch (Exception) {
    return "ERROR " + Exception.toString();
  }
}
