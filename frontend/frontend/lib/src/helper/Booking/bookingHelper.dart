import 'package:flutter/material.dart';
import 'package:frontend/src/provider/booking_provider.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:frontend/src/screens/Booking/bookingDayScreen.dart';

//helper class for booking functionality and business logic
class BookingHelper {
  final bookingProvider = BookingProvider();
  final userProvider = UserProvider();
  //function to perform all logic required when making a booking
  Future<String> checkAndMakeBooking({
    timeslot,
    office,
    bookingDate,
  }) async {
    //if true then make booking
    //else show user booking cant be made
    var result = await bookingProvider.checkAvailibity(timeslot, office);
    if (result == true) {
      //get userID via user provider
      final userID = 1; //userProvider.getUserID();
      //check availibility is true, hence must make create booking call
      return bookingProvider.createBookingAsync(
        bookingDate,
        timeslot,
        office,
        userID,
      );
      //after making booking call, see what response code is and return string based on statusCode
    } else if (result == false) {
      return 'No bookings are availible';
    }
    return 'Error when trying to book.';
    //default return case. If reached and true not yet returned then false is only option
    //possibly replace with thrown exception?
  }

  NavToBookingDayScreen(context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BookingDayScreen('M')));
  }
}
