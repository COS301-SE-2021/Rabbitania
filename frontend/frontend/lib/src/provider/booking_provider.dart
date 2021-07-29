import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/src/models/Booking/view_booking_model.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class BookingProvider {
  Future<ViewBookingModel> fetchBooking() async {
    UserProvider userProvider = new UserProvider();
    int userID = userProvider.getUserID();
    final response = await http.get(
      Uri.parse('https://10.0.2.2:5001/api/Booking/GetBookings?UserId=$userID'),
    );
    if (response.statusCode == 200) {
      return ViewBookingModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception(
        'Failed to load booking' + response.statusCode.toString(),
      );
    }
  }
}
