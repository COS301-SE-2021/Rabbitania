import 'package:flutter/material.dart';
import 'package:frontend/src/provider/booking_provider.dart';
import 'package:frontend/src/provider/user_provider.dart';

//helper class for booking functionality
class BookingHelper {
  final bookingProvider = BookingProvider();
  final userProvider = UserProvider();
  //function to perform all logic required when making a booking
  Future<bool> checkAndMakeBooking({
    timeslot,
    office,
    bookingDate,
  }) async {
    //TODO: check availibility of booking slot
    //if true then make booking
    //else show user booking cant be made
    var result = await bookingProvider.checkAvailibity(timeslot, office);
    if (result == true) {
      //get userID via user provider
      final userID = userProvider.getUserID();
      //check availibility is true, hence must make create booking call
      var createBookingResult = await bookingProvider.createBookingAsync(
        bookingDate,
        timeslot,
        office,
        userID,
      );
      //after making booking call, see what response code is and return boolean based on statusCode
      if (createBookingResult == 'Created new Booking') {
        return true;
      } else {
        //if something went wrong during the createBookingAsync call
        throw (createBookingResult.toString());
      }
      //now booking space availible, hence return false
    } else if (result == false) {
      return false;
    }
    //default return case. If reached and true not yet returned then false is only option
    //possibly replace with thrown exception?
    return false;
  }
}
