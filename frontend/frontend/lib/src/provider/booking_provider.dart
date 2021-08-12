import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/src/models/Booking/bookingModel.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class BookingProvider {
  // GET ALL
  Future<List<ViewBookingModel>> fetchBookingsAsync() async {
    final response = await http.get(
      Uri.parse('https://10.0.2.2:5001/api/Booking/GetBookings?UserId=1'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse
          .map(
            (bookings) => new ViewBookingModel.fromJson(bookings),
          )
          .toList();
    } else {
      List<ViewBookingModel> noBookings = List.empty();

      return noBookings;
    }
  }

  // POST
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
        'userId': userId,
      }),
    );
    if (response.statusCode == 200) {
      return ("Created new Booking");
    } else {
      return ("Failed to create booking, Code: " +
          response.statusCode.toString() +
          " - Response Message: " +
          response.body);
    }
  }

  // DELETE
  Future<bool> deleteBookingAsync(int bookingId) async {
    final response = await http.delete(
      Uri.parse(
          'https://10.0.2.2:5001/api/Booking/DeleteBooking?BookingId=$bookingId'),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //POST
  Future<bool> checkAvailibity(timeslot, office) async {
    final response = await http.post(
      Uri.parse(
          'https://10.0.2.2:5001/api/BookingSchedule/CheckAvailability?TimeSlot'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          'timeSlot': timeslot,
          'office': office,
        },
      ),
    );
    //TODO:make http call to check availibility based on booking pk
    //if true then make booking
    //if false show alert dialog and let user know can't make booking

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
