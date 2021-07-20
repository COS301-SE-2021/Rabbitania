import 'package:flutter/material.dart';

class BookingButton extends StatefulWidget {
  final displayText;
  BookingButton(this.displayText);
  _bookingState createState() => _bookingState();
}

class _bookingState extends State<BookingButton> {
  Widget build(BuildContext context) => Center(
        child: Container(
            child: Column(
          children: <Widget>[
            Center(
              child: Text(widget.displayText),
            ),
          ],
        )),
      );
}
