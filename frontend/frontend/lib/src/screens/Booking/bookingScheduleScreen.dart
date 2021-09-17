import 'package:flutter/material.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/widgets/Booking/bookingGridSchedule.dart';

class BookingSchedules extends StatefulWidget {
  @override
  _BookingScheduleState createState() => _BookingScheduleState();
}

class _BookingScheduleState extends State<BookingSchedules> {
  UtilModel utilModel = UtilModel();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 100,
          elevation: 1,
          backgroundColor: Colors.transparent,
          title: Text(
            'Office Schedules',
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
              BookingGridSchedule(),
            ],
          ),
        ),
      );
}
