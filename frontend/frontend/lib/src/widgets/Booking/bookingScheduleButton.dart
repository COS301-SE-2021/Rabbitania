import 'package:flutter/material.dart';
import 'package:frontend/src/screens/Booking/bookingAdminScheduleScreen.dart';
import 'package:frontend/src/screens/Booking/bookingDayScreen.dart';

class BookingScheduleButton extends StatefulWidget {
  final String displayText;
  final selectedColour;
  BookingScheduleButton(this.displayText, this.selectedColour);
  _BookingScheduleButtonState createState() => _BookingScheduleButtonState();
}

class _BookingScheduleButtonState extends State<BookingScheduleButton> {
  @override
  Widget build(context) => TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.selectedColour),
          shape: MaterialStateProperty.all(
            CircleBorder(
              side: BorderSide(
                width: 2,
                color: Color.fromRGBO(171, 255, 79, 1),
              ),
            ),
          ),
        ),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingScheduleScreen(widget.displayText),
            ),
          ),
        },
        child: Text(
          '${widget.displayText[0]}',
          style: TextStyle(
            fontSize: 40,
            color: Color.fromRGBO(171, 255, 79, 1),
          ),
        ),
      );
}
