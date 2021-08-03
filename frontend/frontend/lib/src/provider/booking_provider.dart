import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/src/models/Booking/viewBookingListModel.dart';
import 'package:frontend/src/models/Booking/view_booking_model.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class BookingProvider {
  Future<List<ViewBookingModel>> fetchBookingsAsync() async {
    //UserProvider userProvider = new UserProvider();
    final response = await http.get(
      Uri.parse('https://10.0.2.2:5001/api/Booking/GetBookings?UserId=1'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return jsonResponse
          .map((bookings) => new ViewBookingModel.fromJson(bookings))
          .toList();
    } else {
      throw Exception('Failed to retreive bookings');
    }
  }
}
