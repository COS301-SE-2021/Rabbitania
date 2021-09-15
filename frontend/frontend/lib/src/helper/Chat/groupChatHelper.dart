import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

class GroupChatHelper extends ChangeNotifier {
  List<int> _usersArray = [];

  get usersArray => _usersArray;

  //used to add users to object instance array
  addUserToArray(int value) {
    _usersArray.add(value);
    notifyListeners();
  }

  //remove users form object instance array
  removeUserFromArray(int value) {
    _usersArray.remove(value);
    notifyListeners();
  }
}
