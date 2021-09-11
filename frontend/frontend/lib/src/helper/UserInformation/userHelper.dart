import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//helper class for all login related functionality
class UserHelper {
  //function used to save userID to disk
  //function is async so must use callback when using
  void setUserID(userID) async {
    //get instance of sharedpreferences obj
    final prefs = await SharedPreferences.getInstance();
    //set instance of userID
    prefs.setInt('userID', userID);
  }

  void setUserName(name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
  }

  void setAdminStatus(isAdmin) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAdmin', isAdmin);
  }

  //funtion used to retrieve stored userID
  //function is async so must use callback when using
  getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userID');
  }

  getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  getAdminStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAdmin');
  }

  //clear all user specific data from disk
  //function is async so must use callback when using
  clearPersitantUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userID');
  }

  clearPersitantUserName() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
  }

  clearPersitantUserStatus() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('isAdmin');
  }

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
