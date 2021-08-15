import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/src/models/util_model.dart';
import 'package:frontend/src/provider/booking_provider.dart';
import 'package:frontend/src/screens/Booking/bookingViewBookings.dart';

class CancelBookingButton extends StatefulWidget {
  final int cancelId;

  CancelBookingButton(this.cancelId);

  @override
  _CancelBookingButton createState() => _CancelBookingButton();
}

class _CancelBookingButton extends State<CancelBookingButton> {
  BookingProvider bookingProvider = new BookingProvider();

  Widget build(context) => SizedBox.fromSize(
        size: Size(50, 50),
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Color.fromRGBO(172, 255, 79, 1),
              onTap: () {
                bookingProvider.deleteBookingAsync(widget.cancelId);
                UtilModel.route(() => ViewBookingScreen(), context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FaIcon(
                    Icons.delete,
                    color: Colors.red,
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
