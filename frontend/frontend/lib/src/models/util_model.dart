import 'package:flutter/material.dart';

//use to shorten call to navigator
//to use: UtilModel.route(()=>*name of route*, context);
class UtilModel {
  final greyColor = Color.fromRGBO(33, 33, 33, 1);
  final greenColor = Color.fromRGBO(171, 255, 79, 1);
  UtilModel.route(Function destination, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination()),
    );
  }
}
