import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//helper class for all login related functionality
class LoginHelper {
  //function used to save userID to disk
  void setUserID(userID) async {
    //get instance of sharedpreferences obj
    final prefs = await SharedPreferences.getInstance();
    //set instance of userID
    prefs.setInt('userID', userID);
  }

  //funtion used to retrieve stored userID
  getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userID');
  }

  //clear all user specific data from disk
  clearPersitantUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('UserID');
  }
}
