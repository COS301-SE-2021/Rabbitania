import 'package:flutter/material.dart';
import 'package:frontend/src/screens/Booking/bookingDayScreen.dart';

class BookingDayButton extends StatefulWidget {
  final displayText;
  final selectedColour;
  BookingDayButton(this.displayText, this.selectedColour);
  _BookingDayState createState() => _BookingDayState();
}

class _BookingDayState extends State<BookingDayButton> {
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
              builder: (context) => BookingDayScreen(widget.displayText),
            ),
          ),
        },
        child: Text(
          widget.displayText,
          style: TextStyle(
            fontSize: 40,
            color: Color.fromRGBO(171, 255, 79, 1),
          ),
        ),
      );
}
