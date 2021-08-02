import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/src/models/Booking/viewBookingListModel.dart';
import 'package:frontend/src/models/Booking/view_booking_model.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class BookingProvider {
  Future<ViewBookingListModel> fetchBooking() async {
    UserProvider userProvider = new UserProvider();
    //int userID = userProvider.getUserID();
    final response = await http.get(
      Uri.parse('https://10.0.2.2:5001/api/Booking/GetBookings?UserId=1'),
    );
    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      List<ViewBookingModel> objList = [];
      print(jsonResponse);
      jsonResponse.forEach((element) {
        print(element);
        objList.add(
          ViewBookingModel.fromJson(
            jsonDecode(element),
          ),
        );
      });
      return ViewBookingListModel(objList);
    } else {
      throw Exception(
        'Failed to load booking' + response.statusCode.toString(),
      );
    }
  }
}
