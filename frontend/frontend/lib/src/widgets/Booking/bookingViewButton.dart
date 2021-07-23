import 'package:flutter/material.dart';

class BookingViewButton extends StatelessWidget {
  const BookingViewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 400.0,
      height: 200.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 20),
          primary: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Color.fromRGBO(171, 255, 79, 1))),
        ),
        onPressed: () {},
        child: const Text('VIEW YOUR CURRENT BOOKINGS',
            style: TextStyle(color: Color.fromRGBO(171, 255, 79, 1))),
      ),
    );
  }
}
