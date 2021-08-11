import 'package:flutter/material.dart';
import 'package:frontend/src/screens/Booking/bookingViewBookings.dart';

class BookingViewButton extends StatelessWidget {
  const BookingViewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 200.0,
      height: 100.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          textStyle: const TextStyle(fontSize: 20),
          primary: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Color.fromRGBO(171, 255, 79, 1))),
        ),
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewBookingScreen()),
          )
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Text(
                'VIEW YOUR',
                style: TextStyle(
                    color: Color.fromRGBO(171, 255, 79, 1), fontSize: 25),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Text(
                'CURRENT BOOKINGS',
                style: TextStyle(
                    color: Color.fromRGBO(171, 255, 79, 1), fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
