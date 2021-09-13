import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/helper/JWT/securityHelper.dart';
import 'package:frontend/src/helper/URL/urlHelper.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/models/Booking/bookingModel.dart';
import 'package:frontend/src/models/Booking/bookingScheduleModel.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:http/http.dart' as http;

class BookingProvider {
  // Booking Provider Instances
  UserHelper loggedUser = new UserHelper();
  SecurityHelper securityHelper = new SecurityHelper();
  URLHelper url = new URLHelper();
  // Variables for the Booking Provider
  var email = FirebaseAuth.instance.currentUser!.providerData[0].email!;

  // GET ALL (GetBookings)
  Future<List<ViewBookingModel>> fetchBookingsAsync() async {
    final loggedUserId = await loggedUser.getUserID();
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    final baseURL = await url.getBaseURL();

    final response = await http.get(
      Uri.parse(baseURL + '/api/Booking/GetBookings?UserId=$loggedUserId'),
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
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'name': await loggedUser.getUserName()
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
    SecurityHelper securityHelper = new SecurityHelper();
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    final baseURL = await url.getBaseURL();

    final response = await http.post(
      Uri.parse(baseURL + '/api/Booking/CreateBooking'),
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
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'name': await loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return createBookingAsync(bookingDate, timeSlot, office, userId);
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
    SecurityHelper securityHelper = new SecurityHelper();
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    final baseURL = await url.getBaseURL();
    final response = await http.delete(
      Uri.parse(baseURL + '/api/Booking/DeleteBooking?BookingId=$bookingId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'name': await loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return deleteBookingAsync(bookingId);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      return false;
    }
  }

  //POST (CheckAvailability)
  Future<bool> checkIfBookingExists(timeSlot, office, userId) async {
    SecurityHelper securityHelper = new SecurityHelper();
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    final baseURL = await url.getBaseURL();
    final response = await http.post(
      Uri.parse(baseURL + '/api/Booking/CheckIfBookingExists'),
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
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'name': await loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return checkIfBookingExists(timeSlot, office, userId);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      return false; // cannot make booking
    }
  }

  //POST (CheckAvailability)
  Future<bool> checkAvailibity(timeslot, office) async {
    SecurityHelper securityHelper = new SecurityHelper();
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    final baseURL = await url.getBaseURL();
    final response = await http.post(
      Uri.parse(baseURL + '/api/BookingSchedule/CheckAvailability?TimeSlot'),
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
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'name': await loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return checkAvailibity(timeslot, office);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      return false;
    }
  }

  //POST (CreateBookingSchedule)
  Future<bool> createBookingSchedule(timeslot, office, availability) async {
    SecurityHelper securityHelper = new SecurityHelper();
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    final baseURL = await url.getBaseURL();
    final response = await http.post(
      Uri.parse(baseURL + '/api/BookingSchedule/CreateBookingSchedule'),
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
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'name': await loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return createBookingSchedule(timeslot, office, availability);
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      return false;
    }
  }

  // GET ALL SCHEDULES (GetBookingSchedules)
  Future<List<BookingScheduleModel>> fetchSchedulesAsync() async {
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();
    final baseURL = await url.getBaseURL();

    final response = await http.get(
      Uri.parse(baseURL + '/api/BookingSchedule/GetBookingSchedules'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      //var schedules = BookingScheduleModel.fromJson(jsonDecode(response.body));
      // List<BookingScheduleModel> jsonResponse = json.decode(response.body);
      final jsonMap = json.decode(response.body);
      List<BookingScheduleModel> schedules =
          (jsonMap['bookingSchedules'] as List)
              .map((itemWord) => BookingScheduleModel.fromJson(itemWord))
              .toList();
      return schedules;
    } else if (response.statusCode == 401) {
      final authReponse = await http.post(
        Uri.parse(baseURL + '/api/Auth/Auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{
          'userID': await loggedUser.getUserID(),
          'name': await loggedUser.getUserName()
        }),
      );
      if (authReponse.statusCode == 200) {
        Map<String, dynamic> obj = jsonDecode(authReponse.body);
        var token = '${obj['token']}';
        securityHelper.setToken(token);
        return fetchSchedulesAsync();
      } else {
        throw new Exception("Error with Authentication");
      }
    } else {
      List<BookingScheduleModel> noSchedules = List.empty();
      return noSchedules;
    }
  }

  static setState(Null Function() param0) {}
}
