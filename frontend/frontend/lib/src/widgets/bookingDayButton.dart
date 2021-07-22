import 'package:flutter/material.dart';
import 'package:frontend/src/screens/bookingDayScreen.dart';

class BookingDayButton extends StatefulWidget {
  final displayText;
  BookingDayButton(this.displayText);
  _BookingDayState createState() => _BookingDayState();
}

class _BookingDayState extends State<BookingDayButton> {
  bool _colorChange = false;

  @override
  Widget build(context) => TextButton(
        style: ButtonStyle(
          backgroundColor: _colorChange
              ? MaterialStateProperty.all(Colors.transparent)
              : MaterialStateProperty.all(Color.fromRGBO(33, 33, 33, 1)),
          shape: MaterialStateProperty.all(CircleBorder(
            side: BorderSide(width: 2, color: Color.fromRGBO(171, 255, 79, 1)),
          )),
        ),
        // style: ButtonStyle(
        //   backgroundColor: MaterialStateProperty.all(Colors.transparent),
        //   shape: MaterialStateProperty.all(CircleBorder(
        //     side: BorderSide(width: 2, color: Color.fromRGBO(171, 255, 79, 1)),
        //   )),
        // ),
        onPressed: () => {
          setState(() => _colorChange = !_colorChange),
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookingDayScreen()),
          )
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
