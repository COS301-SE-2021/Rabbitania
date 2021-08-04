import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/src/models/Booking/bookingModel.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class BookingProvider {
  Future<List<ViewBookingModel>> fetchBookingsAsync() async {
    //UserProvider userProvider = new UserProvider();
    final response = await http.get(
      Uri.parse('https://10.0.2.2:5001/api/Booking/GetBookings?UserId=8'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse
          .map((bookings) => new ViewBookingModel.fromJson(bookings))
          .toList();
    } else {
      throw Exception('Failed to retreive bookings');
    }
  }

  Future<String> createBookingAsync(
      String bookingDate, String timeSlot, int office, int userId) async {
    final response = await http.post(
      Uri.parse('https://10.0.2.2:5001/api/Booking/CreateBooking'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'bookingDate': bookingDate,
        'timeSlot': timeSlot,
        'office': office,
        'userId': 8
      }),
    );
    if (response.statusCode == 200) {
      return ("Created new Booking");
    } else {
      throw ("Failed to create new booking - Error Status: " +
          response.statusCode.toString());
    }
  }
}
