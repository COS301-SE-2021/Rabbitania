import 'package:flutter/material.dart';

class GoogleUser {
  final String token;
  final String email;
  final String givenName;
  final String name;
  final String surname;

  GoogleUser({
    required this.token,
    required this.email,
    required this.givenName,
    required this.name,
    required this.surname,
  });

  factory GoogleUser.fromJSON(Map<String, dynamic> json) {
    return GoogleUser(
      token: json['token'],
      email: json['email'],
      givenName: json['givenName'],
      name: json['name'],
      surname: json['surname'],
    );
  }
}
