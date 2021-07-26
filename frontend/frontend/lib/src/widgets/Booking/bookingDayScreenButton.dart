import 'package:flutter/material.dart';

class BookingDayScreenButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _bookingDayScreenButton();
}

class _bookingDayScreenButton extends State<BookingDayScreenButton> {
  @override
  Widget build(BuildContext context) => Center(
        child: SizedBox(
          width: 200,
          height: 70,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    width: 2,
                    color: Color.fromRGBO(171, 255, 79, 1),
                  ),
                ),
              ),
            ),
            child: Text(
              'Book',
              style: TextStyle(
                fontSize: 30,
                color: Color.fromRGBO(172, 255, 79, 1),
              ),
            ),
            onPressed: () {},
          ),
        ),
      );
}
