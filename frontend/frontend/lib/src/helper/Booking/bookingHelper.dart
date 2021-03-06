import 'package:frontend/src/helper/UserInformation/userHelper.dart';
import 'package:frontend/src/provider/booking_provider.dart';
import 'package:frontend/src/provider/user_provider.dart';

//helper class for booking functionality and business logic
class BookingHelper {
  final bookingProvider = BookingProvider();
  final userProvider = UserProvider();
  final userHelper = new UserHelper();
  //function to perform all logic required when making a booking
  Future<String> checkAndMakeBooking({
    timeslot,
    office,
    bookingDate,
  }) async {
    //Get User Id of the currently logged in user
    final userId = await userHelper.getUserID();

    // return the createBookingAsync method which creates a future to book.
    return bookingProvider.createBookingAsync(
      bookingDate,
      timeslot,
      office,
      userId,
    );
  }

  Future<bool> confirmNoPriorBookings({
    timeslot,
    office,
  }) async {
    //Get User Id of the currently logged in user
    final userId = await userHelper.getUserID();
    // return the createBookingAsync method which creates a future to book.
    return bookingProvider.checkIfBookingExists(timeslot, office, userId);
  }

  Future<bool> createBookingSchedule({timeslot, office, availability}) async {
    // return the createBookingAsync method which creates a future to book.
    return bookingProvider.createBookingSchedule(
        timeslot, office, availability);
  }
}
