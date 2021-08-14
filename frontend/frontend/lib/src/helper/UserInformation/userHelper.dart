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
}
