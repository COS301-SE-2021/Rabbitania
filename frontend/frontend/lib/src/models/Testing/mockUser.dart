import 'package:flutter/material.dart';

class MockUser {
  final String _displayName = 'devilliers';
  final int _phoneNumber = 0835403600;
  final _photoURL = 'images\0861b76ad6e3b156c2b9d61feb6af864.jpg';

  String get displayName {
    return this._displayName;
  }

  int get phoneNumber {
    return this._phoneNumber;
  }

  get photoURL {
    return this._photoURL;
  }
}
