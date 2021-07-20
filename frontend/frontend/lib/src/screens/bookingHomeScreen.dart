import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/widgets/bookingAppBar.dart';
import 'package:frontend/src/widgets/bookingButton.dart';
import 'package:frontend/src/widgets/bookingDayButton.dart';

class BookingScreen extends StatefulWidget {
  @override
  _bookingState createState() => _bookingState();
}

class _bookingState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 100,
          elevation: 1,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              BookingDayButton('M'),
              BookingDayButton('T'),
              BookingDayButton('W'),
              BookingDayButton('T'),
              BookingDayButton('F'),
            ],
          ),
        ),
        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                BookingButton('Afternoon'),
              ],
            ),
          ),
        ),
      );
}
