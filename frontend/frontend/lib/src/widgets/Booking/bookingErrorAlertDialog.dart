import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Booking/bookingHelper.dart';

class BookingErrorAlertDialog extends StatelessWidget {
  Widget build(context) => AlertDialog(
        title: const Text('No Bookings Availible'),
        content: const Text(
            'Unfortunately there are no booking slots availible at this time. Please try again later'),
        actions: <Widget>[
          TextButton(
            //on press to retry booking process, function takes user back to monday booking day screen
            onPressed: () => BookingHelper().NavToBookingDayScreen(context),
            child: const Text('Retry'),
          ),
        ],
      );
}
