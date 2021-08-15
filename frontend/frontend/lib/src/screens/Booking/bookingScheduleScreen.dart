import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/models/Booking/bookingModel.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/booking_provider.dart';
import 'package:frontend/src/provider/user_provider.dart';
import 'package:frontend/src/screens/Booking/bookingHomeScreen.dart';
import 'package:frontend/src/widgets/Booking/bookingAppBar.dart';
import 'package:frontend/src/widgets/Booking/bookingButton.dart';
import 'package:frontend/src/widgets/Booking/bookingDayButton.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/src/widgets/Booking/bookingViewButton.dart';
import 'package:frontend/src/widgets/Booking/viewBookingCard.dart';

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
                utilModel.svg_background,
                fit: BoxFit.contain,
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(color: Colors.transparent);
                  },
                ),
              ),
            ],
          ),
        ),
      );
}
