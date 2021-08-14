import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/src/helper/JWT/securityHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/Booking/bookingModel.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class BookingProvider {
  UserHelper loggedUser = new UserHelper();
  SecurityHelper securityHelper = new SecurityHelper();

  // GET ALL (GetBookings)
  Future<List<ViewBookingModel>> fetchBookingsAsync() async {
    final loggedUserId = await loggedUser.getUserID();
    final token = await securityHelper.getToken();
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
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse('https://10.0.2.2:5001/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return fetchBookingsAsync();
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      List<ViewBookingModel> noBookings = List.empty();

      return noBookings;
    }
  }

  // POST (CreateBooking)
  Future<String> createBookingAsync(
      String bookingDate, String timeSlot, int office, int userId) async {
    var bd = bookingDate;
    var ts = timeSlot;
    var of = office;
    var uid = userId;

    SecurityHelper securityHelper = new SecurityHelper();
    final token = await securityHelper.getToken();
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
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse('https://10.0.2.2:5001/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return createBookingAsync(bd, ts, of, uid);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      return ("Failed to create booking, Code: " +
          response.statusCode.toString() +
          " - Response Message: " +
          response.body);
    }
  }

  // DELETE (DeleteBooking)
  Future<bool> deleteBookingAsync(int bookingId) async {
    var bid = bookingId;
    SecurityHelper securityHelper = new SecurityHelper();
    final token = await securityHelper.getToken();
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
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse('https://10.0.2.2:5001/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return deleteBookingAsync(bid);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      return false;
    }
  }

  //POST (CheckAvailability)
  Future<bool> checkIfBookingExists(timeSlot, office, userId) async {
    var ts = timeSlot;
    var of = office;
    var uid = userId;

    SecurityHelper securityHelper = new SecurityHelper();
    final token = await securityHelper.getToken();
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
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse('https://10.0.2.2:5001/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return checkIfBookingExists(ts, of, uid);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      return false; // cannot make booking
    }
  }

  //POST (CheckAvailability)
  Future<bool> checkAvailibity(timeslot, office) async {
    var ts = timeslot;
    var of = office;
    SecurityHelper securityHelper = new SecurityHelper();
    final token = await securityHelper.getToken();
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
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse('https://10.0.2.2:5001/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return checkAvailibity(ts, of);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      return false;
    }
  }

  //POST (CreateBookingSchedule)
  Future<bool> createBookingSchedule(timeslot, office, availability) async {
    var ts = timeslot;
    var of = office;
    var av = availability;

    SecurityHelper securityHelper = new SecurityHelper();
    final token = await securityHelper.getToken();
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
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse('https://10.0.2.2:5001/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': loggedUser.getUserID(),
          'name': loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return createBookingSchedule(ts, of, av);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      return false;
    }
  }
}
