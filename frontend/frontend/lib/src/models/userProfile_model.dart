import 'package:flutter/material.dart';

class UserProfileModel {
  String name;
  String userImage;
  String description;
  String? phoneNumber;
  int empLevel;
  int officeLocation;
  int userRoles;

  UserProfileModel({
    required this.name,
    required this.userImage,
    required this.description,
    required this.phoneNumber,
    required this.empLevel,
    required this.officeLocation,
    required this.userRoles,
  });

  factory UserProfileModel.fromJSON(Map<String, dynamic> json) {
    return UserProfileModel(
        name: json['name'],
        userImage: json['userImage'],
        description: json['description'],
        phoneNumber: json['phoneNumber'],
        empLevel: json['empLevel'],
        officeLocation: json['officeLocation'],
        userRoles: json['userRoles']);
  }
}
