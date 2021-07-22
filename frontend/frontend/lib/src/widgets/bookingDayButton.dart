import 'package:flutter/material.dart';

class BookingDayButton extends StatefulWidget {
  final displayText;
  BookingDayButton(this.displayText);
  _bookingDayState createState() => _bookingDayState();
}

class _bookingDayState extends State<BookingDayButton> {
  @override
  Widget build(context) => TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(CircleBorder(
            side: BorderSide(width: 2, color: Color.fromRGBO(171, 255, 79, 1)),
          )),
        ),
        onPressed: () {},
        child: Text(
          widget.displayText,
          style: TextStyle(
            fontSize: 40,
            color: Color.fromRGBO(171, 255, 79, 1),
          ),
        ),
      );
}
