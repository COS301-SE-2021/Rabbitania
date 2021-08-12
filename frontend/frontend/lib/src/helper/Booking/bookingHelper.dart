import 'package:flutter/material.dart';
import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/provider/booking_provider.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:frontend/src/screens/Booking/bookingDayScreen.dart';

//helper class for booking functionality and business logic
class BookingHelper {
  final bookingProvider = BookingProvider();
  final userProvider = UserProvider();
  final loggedUser = new UserHelper();
  //function to perform all logic required when making a booking
  Future<String> checkAndMakeBooking({
    timeslot,
    office,
    bookingDate,
  }) async {
    //Get User Id of the currently logged in user
    final loggedUserId = await loggedUser.getUserID();

    // return the createBookingAsync method which creates a future to book.
    return bookingProvider.createBookingAsync(
      bookingDate,
      timeslot,
      office,
      loggedUserId,
    );
  }

  Future<bool> confirmNoPriorBookings({
    timeslot,
    office,
  }) async {
    //Get User Id of the currently logged in user
    final loggedUserId = await loggedUser.getUserID();
    // return the createBookingAsync method which creates a future to book.
    return bookingProvider.checkIfBookingExists(timeslot, office, loggedUserId);
  }
}
