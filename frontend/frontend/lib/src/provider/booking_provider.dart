import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/Booking/bookingModel.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class BookingProvider {
  UserHelper loggedUser = new UserHelper();

  // GET ALL (GetBookings)
  Future<List<ViewBookingModel>> fetchBookingsAsync() async {
    final loggedUserId = await loggedUser.getUserID();
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
    final response = await http.get(
      Uri.parse(
          'https://10.0.2.2:5001/api/Booking/GetBookings?UserId=$loggedUserId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
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

  // POST (CreateBooking)
  Future<String> createBookingAsync(
      String bookingDate, String timeSlot, int office, int userId) async {
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
    final response = await http.post(
      Uri.parse('https://10.0.2.2:5001/api/Booking/CreateBooking'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
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

  // DELETE (DeleteBooking)
  Future<bool> deleteBookingAsync(int bookingId) async {
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
    final response = await http.delete(
      Uri.parse(
          'https://10.0.2.2:5001/api/Booking/DeleteBooking?BookingId=$bookingId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //POST (CheckAvailability)
  Future<bool> checkIfBookingExists(timeSlot, office, userId) async {
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
    final response = await http.post(
      Uri.parse('https://10.0.2.2:5001/api/Booking/CheckIfBookingExists'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        <String, dynamic>{
          'timeSlot': timeSlot,
          'office': office,
          'userId': userId
        },
      ),
    );
    if (response.statusCode == 200) {
      return true; // can make booking
    } else {
      return false; // cannot make booking
    }
  }

  //POST (CheckAvailability)
  Future<bool> checkAvailibity(timeslot, office) async {
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
    final response = await http.post(
      Uri.parse(
          'https://10.0.2.2:5001/api/BookingSchedule/CheckAvailability?TimeSlot'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        <String, dynamic>{
          'timeSlot': timeslot,
          'office': office,
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //POST (CreateBookingSchedule)
  Future<bool> createBookingSchedule(timeslot, office, availability) async {
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiUnVudGltZVRlcnJvcnMiLCJleHAiOjE2Mjg5NjkyNDcsImlzcyI6InJ1bnRpbWUudGVycm9ycyIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDE7aHR0cDovL2xvY2FsaG9zdDo1MDAwIn0.MBTk3DXysmd7UxtLRuDEzLMXfUH0yeaoU8BluEnW3b0";
    final response = await http.post(
      Uri.parse(
          'https://10.0.2.2:5001/api/BookingSchedule/CreateBookingSchedule'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
        <String, dynamic>{
          'timeSlot': timeslot,
          'office': office,
          'availability': availability
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
