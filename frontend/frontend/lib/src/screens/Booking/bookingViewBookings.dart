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
                utilModel.svg_background,
                fit: BoxFit.contain,
              ),
              Center(
                child: BookingListView(),
                //child: const MyStatelessWidget(),
              ),
            ],
          ),
        ),
      );
}
