import 'package:flutter/material.dart';

class BookingViewButton extends StatelessWidget {
  const BookingViewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: const Text('VIEW YOUR BOOKINGS'),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          side: BorderSide(width: 20.0, color: Colors.blue),
        )),
        foregroundColor:
            MaterialStateProperty.all(Color.fromRGBO(171, 255, 79, 1)),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
      ),
    );
  }
}
