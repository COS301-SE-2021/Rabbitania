import 'package:flutter/material.dart';

class BookingHomeText extends StatefulWidget {
  final displayText;
  BookingHomeText(this.displayText);
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<BookingHomeText> {
  Widget build(BuildContext context) => Center(
        child: Container(
            child: Column(
          children: <Widget>[
            Center(
              child: Text(widget.displayText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 25,
                      color: Color.fromRGBO(171, 255, 79, 1))),
            ),
          ],
        )),
      );
}
