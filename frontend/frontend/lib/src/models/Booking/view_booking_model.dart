import 'package:flutter/material.dart';

class ViewBookingModel {
  final DateTime date;
  final String day;
  final String timeSlot;
  final String office;

  ViewBookingModel({
    required this.date,
    required this.day,
    required this.timeSlot,
    required this.office,
  });

  factory ViewBookingModel.fromJson(Map<String, dynamic> json) {
    return ViewBookingModel(
      date: json['date'],
      day: json['day'],
      timeSlot: json['timeSlot'],
      office: json['office'],
    );
  }
}
