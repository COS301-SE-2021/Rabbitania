import 'package:flutter/material.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/widgets/Booking/viewBookingCard.dart';

class ViewBookingScreen extends StatefulWidget {
  @override
  _ViewBookingState createState() => _ViewBookingState();
}

class _ViewBookingState extends State<ViewBookingScreen> {
  UtilModel utilModel = UtilModel();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 100,
          elevation: 1,
          backgroundColor: Colors.transparent,
          title: Text(
            'Your Bookings',
            style: TextStyle(
              fontSize: 30,
              color: Color.fromRGBO(171, 255, 79, 1),
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
        body: Center(
          child: Stack(
            children: <Widget>[
              SvgPicture.string(
                utilModel.svgBackground,
                fit: BoxFit.contain,
              ),
              Center(
                child: BookingListView(),
              ),
            ],
          ),
        ),
      );
}
