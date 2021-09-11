import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class GroupChatHelper extends ChangeNotifier {
  List<int> _usersArray = [];
  var GroupChatImage;
  //to get length of users array
  get usersArray => _usersArray;
  //to get array with all userID's participating in group chat

  addUserToArray(int value) {
    _usersArray.add(value);
    notifyListeners();
  }

  removeUserFromArray(int value) {
    _usersArray.remove(value);
    notifyListeners();
  }
}
