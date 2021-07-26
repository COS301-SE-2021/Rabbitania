import 'package:flutter/material.dart';

class BookingDayText extends StatefulWidget {
  final displayText;
  BookingDayText(this.displayText);
  _BookingDayTextState createState() => _BookingDayTextState();
}

class _BookingDayTextState extends State<BookingDayText> {
  Widget build(BuildContext context) => Center(
        child: Container(
            child: Column(
          children: <Widget>[
            Center(
              child: Text(widget.displayText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 40,
                      color: Color.fromRGBO(171, 255, 79, 1))),
            ),
          ],
        )),
      );
}
