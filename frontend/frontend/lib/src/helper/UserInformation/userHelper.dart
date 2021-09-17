import 'package:shared_preferences/shared_preferences.dart';

class UserHelper {
  //function to store userId to shared preferences(local storage)
  void setUserID(userID) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('userID', userID);
  }

  //function to store user name to shared preferences(local storage)
  void setUserName(name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }

  //function to store a users admin status to shared preferences(local storage)
  void setAdminStatus(isAdmin) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAdmin', isAdmin);
  }

  //function to get a user's id from shared preferences(local storage)
  getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userID');
  }

  //function to get a user's name from shared preferences(local storage)
  getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  //function to get a user's admin status from shared preferences(local storage)
  getAdminStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAdmin');
  }

  //function to clear a users id from shared preferences(local storage)
  clearPersitantUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userID');
  }

  //function to clear a users name from shared preferences(local storage)
  clearPersitantUserName() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
  }

  //function to clear a users admin status from shared preferences(local storage)
  clearPersitantUserStatus() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('isAdmin');
  }

  //function to determine the role in terms of a string, given a integer
  String determineRolePassIn(int r) {
    switch (r) {
      case 0:
        return 'Developer';
      case 1:
        return 'Designer';
      case 2:
        return 'Administrator';
      case 3:
        return 'Care Taker';
      case 4:
        return 'Scrum Master';
      case 5:
        return 'CAM';
      case 6:
        return 'Director';
      case 7:
        return 'Graduate';
      case 8:
        return 'Intern';
      default:
        return 'Unassigned';
    }
  }

  //function to return an office string, given an integer
  String determineOfficePassIn(r) {
    switch (r) {
      case 0:
        return 'Pretoria';
      case 1:
        return 'Braamfontein';
      case 2:
        return 'Amsterdam';
      default:
        return 'Undetermined';
    }
  }
}
